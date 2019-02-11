Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C674FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:06:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AC421B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5kBgwkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AC421B68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UbpB5j3mZNwwyiMZeC23UI/4PK+NwsHQZUv2CPtizy8=; b=P5kBgwkKMd7M+c
	XEIpXbAeHHv7bPtRmW5NbSi+ziiJ41g+9zC4DMMYwJkhm8k7LWBGPKDQrZunyaB6qVKfj9Vl7kq7a
	SHJB6b/NF5LtmIuzo3zpO9IXwYKYyUA6aJNZkVhSUIVVNGrU0nxD7Tf1rnQZq2Y/dlzToy8tHhvJK
	KlDt6jad4NzyvN+C/e8FS2cidNMDSw8lEu24/Ei4M64zNL67YA4rEbxoQSgEsKaltj0WbEP87XZI0
	tgAh/ttDsapK4aASLyXU0xVSl7EEAtjTa7iEfxd2csnamTa8T/ltd3puKv4pnrxYj7/67WncDewYQ
	FpJ8edn5kokiGdjcitjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtGuk-0004yP-Ui; Mon, 11 Feb 2019 19:06:46 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtGub-0004x0-JF
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 19:06:44 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtGuU-00066d-Ph; Mon, 11 Feb 2019 20:06:30 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtGuS-0007sp-If; Mon, 11 Feb 2019 20:06:28 +0100
Date: Mon, 11 Feb 2019 20:06:28 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Message-ID: <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_110637_791436_414B7DEE 
X-CRM114-Status: GOOD (  16.54  )
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
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Fabrice,

On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - pwm_get()
> - devm_pwm_get()
> - devm_of_pwm_get()
> as it requires a reference to the device for the PWM consumer.
> =

> [1] https://lkml.org/lkml/2019/2/5/770
> =

> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..2835e27 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -770,8 +770,13 @@ struct pwm_device *pwm_get(struct device *dev, const=
 char *con_id)
>  	int err;
>  =

>  	/* look up via DT first */
> -	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> -		return of_pwm_get(dev->of_node, con_id);
> +	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node) {
> +		pwm =3D of_pwm_get(dev->of_node, con_id);
> +		if (!IS_ERR(pwm))
> +			device_link_add(dev, pwm->chip->dev,
> +					DL_FLAG_AUTOREMOVE_CONSUMER);
> +		return pwm;
> +	}
>  =

>  	/*
>  	 * We look up the provider in the static table typically provided by
> @@ -851,6 +856,8 @@ struct pwm_device *pwm_get(struct device *dev, const =
char *con_id)
>  	pwm->args.period =3D chosen->period;
>  	pwm->args.polarity =3D chosen->polarity;
>  =

> +	device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
>  	return pwm;
>  }
>  EXPORT_SYMBOL_GPL(pwm_get);
> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev=
, struct device_node *np,
>  	if (!IS_ERR(pwm)) {
>  		*ptr =3D pwm;
>  		devres_add(dev, ptr);
> +		device_link_add(dev, pwm->chip->dev,
> +				DL_FLAG_AUTOREMOVE_CONSUMER);

IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
+ devres stuff. I'd put device_link_add() into of_pwm_get().

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
