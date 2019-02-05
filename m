Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346DC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EF52184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFnnnyXE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GytBsCPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EF52184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jkPXxSR0/zL01pbq/ACuyGojNTy/rIT4TQQdkCMf3hQ=; b=OFnnnyXE2UsuzVEdrgY36P/sI
	lO2OJNXbiTi+bDM37KrAwlOZDLqBtS3GzP2PDm6kl+oDAMBwWJVxqeviPqbfX4jvanGY+mYPTXVO0
	fty03ZyqC98/GiNJ/hRWAbgptYYMAjtFfpKUpM0EsMZ5V2mGbmkBkbX5mz558lholbUuwZDTiOenb
	/dvANG5lIv3k7x69Wymonx7e0KzBcYZsyr7SaYV5KZbsDY0TBxgFVtH0riV6r8ZqWKRUfq8kHaAPP
	YKN6o/y4s9j/xdyU0YLqsOm4lbnr7QJZ15hokDgYxOrBI+702KX/rXwX7a+CtKSXVRoIXiT1mP9N5
	Jhbw5YCNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr99m-0007L7-KO; Tue, 05 Feb 2019 22:25:30 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr99j-0007KR-7i
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:25:28 +0000
Received: by mail-wm1-x341.google.com with SMTP id z5so591155wmf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kWqKlXMiV+ZByaIZsuunIJt272UQR46Y+r+AE9Ezzjs=;
 b=GytBsCPGEfmQjisiSrXMpFyNUK68yJzLdaiSOit18M9UhU3fpC01uXGnta+yCNKZkv
 YR04pByVR94qMQsh2R7uUhvmNUY1vRCR0n7bT8BtfjUr1ut7z8CrBkfrYq6E2ZgmGzOC
 uwyT8PQAgH9xSbvNdb9gUBJyhU93OvjI8X8JJM2juMRDUeBmeiDj66CAsHhkxVTedRk+
 E6TQZPSNWL8auw7GUdjmxxCruZUpEq28nObqt4V7WQY31N3WVBTkK5GsiiCI3vX3o5Xx
 f5oyhpSGpgkzUMK4j263x1YC00hlmkBetD6Yo8Jfcikdta02RiyRi/Gzz7tm4m8LJesf
 fo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kWqKlXMiV+ZByaIZsuunIJt272UQR46Y+r+AE9Ezzjs=;
 b=I6elOTlh7eHr3khGqJ5vfvyZ5GbPfzSM7CsEaUTnsrryhOEcvq8emI3X+QdFql1v6A
 fg1aqDna7+I2UIRflEuVD3RiEvahzsVwrtjbnt/76ZQpZue8O+kUVKffXwEUoq601NsA
 7WX8XICTp4T/pdrXa/hxcdD+tn/yD8d+DE5WnLxC8XrNtTkbhEG4F+ZM/DaHIK8ZtVhj
 Z8CrArUOIPqfKMV0o4QjyPi6n6iz5+PdQQNbrjUy6MozQYTHvDmJwKvdDcAzRdH9YkR0
 02VWNooYLrhepPlkGELJROz5Ixu9VvP5MRccmVmiag5aPM8eOFl3HKH+huEVG35JiFjk
 LWog==
X-Gm-Message-State: AHQUAubTfpm7yX0vsGOPc/JJa+Jy5FLfcPcyqmudCFnkYUT8QQhloRkk
 fJfN8eRLk9Y+jK1qEToo0Dg=
X-Google-Smtp-Source: AHgI3IZTkMa0cGXtPoYEuLAVlL1SmypVvokTqLVXwoBK4uO5zqcsEiVm6XYAvamZaIClvLHwSnSwhw==
X-Received: by 2002:a1c:ef11:: with SMTP id n17mr636437wmh.112.1549405525434; 
 Tue, 05 Feb 2019 14:25:25 -0800 (PST)
Received: from localhost
 (p200300E41F128C00021F3CFFFE37B91B.dip0.t-ipconnect.de.
 [2003:e4:1f12:8c00:21f:3cff:fe37:b91b])
 by smtp.gmail.com with ESMTPSA id 133sm22469378wme.9.2019.02.05.14.25.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 14:25:24 -0800 (PST)
Date: Tue, 5 Feb 2019 23:25:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190205222522.GB1372@mithrandir>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_142527_297696_46496455 
X-CRM114-Status: GOOD (  26.41  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, vilhelm.gray@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 Fabrice Gasnier <fabrice.gasnier@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org
Content-Type: multipart/mixed; boundary="===============7044275383248472466=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7044275383248472466==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:47:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
> > Add suspend/resume PM sleep ops. When going to low power, disable
> > active PWM channel. Active PWM channel is resumed, by calling
> > pwm_apply_state(). This is inspired by Thierry's comment in [1].
> > Don't touch inactive channels, as it may be used by other LPTimer MFD
> > child driver.
> > [1]https://lkml.org/lkml/2017/12/5/175
> >=20
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> > index 0059b24c..0c40d48 100644
> > --- a/drivers/pwm/pwm-stm32-lp.c
> > +++ b/drivers/pwm/pwm-stm32-lp.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/mfd/stm32-lptimer.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> > =20
> > @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
> >  	struct pwm_chip chip;
> >  	struct clk *clk;
> >  	struct regmap *regmap;
> > +	struct pwm_state suspend;
> > +	bool suspended;
> >  };
> > =20
> >  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *ch=
ip)
> > @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_dev=
ice *pdev)
> >  	return pwmchip_remove(&priv->chip);
> >  }
> > =20
> > +#ifdef CONFIG_PM_SLEEP
> > +static int stm32_pwm_lp_suspend(struct device *dev)
> > +{
> > +	struct stm32_pwm_lp *priv =3D dev_get_drvdata(dev);
> > +
> > +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
> > +	priv->suspended =3D priv->suspend.enabled;
> > +
> > +	/* safe to call pwm_disable() for already disabled pwm */
> > +	pwm_disable(&priv->chip.pwms[0]);
> > +
> > +	return pinctrl_pm_select_sleep_state(dev);
>=20
> IMHO a PWM should not stop if the PWM user didn't call pwm_disable() (or
> pwm_apply_state() with .enabled =3D false).
>=20
> I don't understand all the PM details, but I think there is no defined
> order in which devices are signalled to suspend. If so the PWM might be
> stopped before its consumer. Then the PWM changes state without the
> consumer being aware of that.
>=20
> I understand Thierry's position in the link you provided in the commit
> log consistant with my position here.

Agreed, we should let users of the PWM take care of resuming the PWM in
the state and at the point in time that they require so. PWM users will
also likely do a pwm_disable() during their suspend implementation, so
doing this again in a PWM ->suspend() is not necessary, even if perhaps
harmless.

So this leaves only the pinctrl_pm_select_sleep_state() call. That seems
fine, but I'm not sure that that's currently guaranteed to work. I think
we may need to implement device link support in the PWM framework to
guarantee the proper suspend/resume sequencing. Otherwise you may end up
in a situation where the PWM is actually suspended before the user and
glitch the pins before the user has a chance to disable the PWM.

I think it'd be fine to merge the driver change here first before we add
device link support if this works for you. Just mentioning the issue
here in case you ever run into it.

Thierry

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxaDU8ACgkQ3SOs138+
s6HIUg/+MBv4yfO0gFeRJM8ZceH9qudcTpN9AN8hEwCrzDssQnbs2xqzGKlcj/x9
pbPd76H/QLjtXeaEILnH6kbpSWZz8I2u9/2SNJ03EzlhhYp+IfE3HwYuvyjCCHEK
d2JCK9X+NDko2K8WBOrtgHYc/KFBhl8GSH/D5ffKpjHg6nJXLOUyfFN48u0YLLXL
OlIdNxoMiUAoYcemG4kO2r/peYBsmYwoKX/mxcZEiLF846HPxxy0KrBGo+Ikzd/D
Kk+bg77SwQhCwQ6fTFWkxPw6lPXaOFGF94KFnUsLaS7Rzx/ti/qfoMgDDbeaB4ME
UpEegQnSOwQ07ruYKAUwFC36HwIii8/60wpdFDlGnZ3i3hYrSHl/mQZHg4mr+/Tt
/41UFS46SkrRy8dJi01O7YTC2k3vWuiHA7fQGz5maWmD1e3vkcVMWk3397rJHKMd
1IYVW4VX8rYOOz/86PXVbCmSY8ElN48zSVB0FEnVaSSbWe8fZ4JSDeOVLVqw/O0Z
lZn8bLFURpagSjFlOX9w9Kr5S9Pl6OvnAdQNTEThhJ8CnKBDnAzDydezQ+a8kLir
/+556979QT0YE+epNlqe7d72BsE+1R3Hep2t7dq6Cx2CLRIqJbktycpUrTe3RdgL
eMT/K20QoEenAgKsqh66pJjJz5RHkI9tqxeKBud8LZs5rWnUZvk=
=jnFr
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


--===============7044275383248472466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7044275383248472466==--

