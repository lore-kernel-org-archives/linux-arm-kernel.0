Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:56:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179DD20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nDQzbMFV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lntAZsQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179DD20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dDXsdZpsZnQ9pLyTHWE5ITTBzSyYvDP2RxjZn+Hy9eU=; b=nDQzbMFVxhUlFXfU9up2YqMoi
	pmX+To3Akcl8oBhkiSriTKhXqoM/ZvF7XXD66HBQa1xP/0Tk1K7Cid78qawDE4FnHyK8WBAFEt6wF
	Ie5NhYobsoCdIv9k5HuJkJ/4tKLPbkdOE4ikkoYoaJlOiOYkfjfInQ7tOYITb43gTE3Pxs/8khm13
	UJltem7QcUsPii4fDAy6GvOXY5ZrGGz0FBzRfhLmoMz6EOIHmq425t5SI1xFHQgwHwvczriZhtWGi
	TRdsqUIjbPyEJ1VQnZyQhIsdsWXuNJ/Yu3mNjRm4+ZTC+EprvITQB0h6xO4xtVeHpuPEeU8cb8SMp
	7gK0+dJyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grMk4-0007ki-Ui; Wed, 06 Feb 2019 12:55:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grMk1-0007k3-6C
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:55:50 +0000
Received: by mail-wm1-x342.google.com with SMTP id y8so2570820wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vZx4P1PdN5ThifFFMSL4i/6yprDS3Sosy76ja/tPiC4=;
 b=lntAZsQ554Dc/9FxC8DLHuhk8yjb+JoBOq7uDUHpL9DO/Cm7+C1WuV8gd1nBygc2cb
 ztLxtq1Kr2+gBoG32cKFAGZbuayqEbixe/Shg0a4hOJ8EVxftSMRKXymmsLZYa2pOcfl
 Flm+ZfOijDwrNImUCP+evCCgNycZIKSZENkKOgrYNMDUxhSI+Ma35+CeoXY+KtldbvuD
 2IE/Yx8XyiNIx0J9Xx1Y6iB7vdukV6WkX8tLscCIV8+kLgrYtYdCfhvYwxCtAhagM8OO
 bSvE7hcH5rydNQXWpzrCoFj0rF3JVCfLOxDddSOeHGouxgQ7k3WhzWq2KugE56qqya2V
 xgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vZx4P1PdN5ThifFFMSL4i/6yprDS3Sosy76ja/tPiC4=;
 b=Ifpvn/njaQB+SW5VL9a2r0bSUy3KvLdI0cg1UiA2GrxaTeC+l/GjvvixXme7belO65
 ezsNkSED9GZtDGTTfSUu03HWf+WhERhbYmseGtDLV8fNSx0cFsCmWvlha14TeAWWE/SQ
 q32sjkpC8CR4OHM9KPfHOFm8vFTNwqBXz/zr2wHDhCWESG2X4tN78xDXnc/mWEKIpHxE
 3u82JQPSo6bfm2HIx37PL31ChF3Bpp/STQnkzvNJVNyXknmezEvQiEJtn2bQk/4Jq+0l
 vm775JuWZrojBOVOWI6MuYCgUyJp5bN7dzexRuz0P+4s7uXvMof+Ds468iFTUYKxmKpr
 FKcw==
X-Gm-Message-State: AHQUAuZfFDAK5cX/Eds55SxVp1XOza4twdF/YXSbXiBO0SZrYRcZoKvL
 Z0etAfTfMDaii7HGQMvRsNk=
X-Google-Smtp-Source: AHgI3IaxAf/66h4v+3Hy77NV2TeD9AAxmHFY4/C6jY1hCmC7jUU+KLRSioELd5peUtR3keUyTDlOyg==
X-Received: by 2002:a1c:e911:: with SMTP id q17mr3359006wmc.31.1549457747564; 
 Wed, 06 Feb 2019 04:55:47 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id c129sm15089075wma.48.2019.02.06.04.55.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 04:55:46 -0800 (PST)
Date: Wed, 6 Feb 2019 13:55:45 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190206125545.GI21676@ulmo>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
 <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_045549_253145_3942E0F7 
X-CRM114-Status: GOOD (  14.85  )
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
 Tomasz Duszynski <tduszyns@gmail.com>, linux-kernel@vger.kernel.org,
 vilhelm.gray@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 Fabrice Gasnier <fabrice.gasnier@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org
Content-Type: multipart/mixed; boundary="===============6135796782279063468=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6135796782279063468==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Content-Disposition: inline


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 09:54:05AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
> > If you agree with the current approach, I can send a V2 with Tomasz's
> > suggestion to remove the ifdefs and use __maybe_unused instead.
>=20
> I think the suspend callback should have something like:
>=20
> 	if (is_still_enabled) {
> 		/*
> 		 * The consumer didn't stop us, so refuse to suspend.
> 		 */
> 		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
> 		return -EBUSY;
> 	}
>=20
> This way there are no bad surprises if the pwm is suspended before its
> consumer and it's obvious what is missing.

Something that just occurred to me: perhaps as part of pwm_get() we
should track where we were being requested from so that we could give
hints in situations like this as to where the consumer is that forgot
to suspend the PWM.

I suppose we already have pwm_device.label to help with this, but
perhaps we could improve things if we stored __builtin_return_address
during pwm_get() to help users pinpoint where they need to look.

Thierry

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa2VEACgkQ3SOs138+
s6EMtQ/+NuYEI6bg9mbWLyhJ3zRbtXrmiV+D2Rr3AvfBXKYks4TF9pGSJFk3f/L+
GLjT4DXZqqCHlnZkHRkvUe/FVjwkSvusTwcQE6TPYZ9ikPG1pXoaA8mFAR9NS4Yf
E0RWwnoMkIpnvF82peQf1zb1ZIlaSwidvFYTA3XYXjdRXzjipix2qkYy55K9FBU7
X9z6uJlAk7UgoTNXKmt+C6VPLTKdQ0TGcN7j/mVIv9cBeYaRzqrUicTqDqMU+Qw1
2kZDJwaXqD4wB0ai8631f2sdruSlIREg8+M4HydMZxiwuqZ0zuX2I3Gm2ihdUQ3P
fFkslyeUouUJ0IWGtZMY1Y5HexCKD3iN837g7Iugpo4rvr2ububpfiCuG1o7v/W4
n3jO7/K0SmjBO+iMiaFgmoaJeEIvg+F+64n54F5ZNdnk1+dVWwJJhHFTtpsGq1c8
bK+MNRdVlwGRug61fIXKQSKPqkr+Flx6xYv+y0AZZ/fGV5Lujx4vJgydUdnfKrqV
OWivKy6KysxAMbgmyyxfDkx06GPlSPk/g7iJ37I5SeHwuie9HWi7M1iycPYIdo+x
hlYJOJOfhXQ+WxaBQ8u6xGW7a4SBJbOKdup60mkVftOJT7yl0ydHtWdOyXpJ92xX
RxWJVBo7WifuGP/40vv6Kz9XFYXBvlCOO1xvvbkismhJjAqVFHo=
=Re92
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--


--===============6135796782279063468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6135796782279063468==--

