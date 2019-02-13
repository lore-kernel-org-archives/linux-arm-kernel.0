Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ACBC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:54:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED335206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SMFqtp17";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz6tsB78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED335206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aOuZ+AsidofKgpsFwQtuhH6qdajfj0537f/SkAc39SY=; b=SMFqtp17JebT41zRjUy8ag99W
	2RxvA+jX8NAcxc504iilg4T2rNSKY4RZ1lTPHGZMbhxwY4dML9RLhYlUQzLVQ1/wDhna59xYy9dEp
	tMC8Rv+onnF4Z4OKTe/EToP5iMAhqoTUCPmNLmx6RP57LYjgY6/4qf59ZnjDVgmt5OUazzGsEJeGC
	Pq/L2lIwyWMC1KVpsnzPLlRD5iySWDGmS8kk8r15C/Y9XT9UcYoMyRR1eZx8IJqvZk3L/qntL1TRV
	tgdqYKQW+QwLcYbS25PE8NaA0I2FodIcb1TWLDM6jfF7qaXtjbzTAqYUOpUSsYleMikRhUPxDr66U
	BANR6YMbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtu36-0005et-ND; Wed, 13 Feb 2019 12:54:00 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtu33-0005du-0J
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:53:58 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so2310655wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Nzo7XXlf1TvFAdO72ji9ouH3fWFVK+LwFHWJE2tCDeg=;
 b=nz6tsB78U3dVyw2qKDSKWtsbUhTK4tDQc7MUh9BErHDmgsey5e3xkr1zmxkqprReqy
 s91ZfkAyqHvWz95GVYxjkU8WR7D290eR0O6OMDJbn33uve5Bhjlw001vvplYAeyC0Iim
 SzBp9lko1N1DNZ/YAFhY+oWejSZYr0Kk3O4/vMGwVoSA1aqLNGh3xdpp3hPuH4hsvmTL
 Truxs23NrdIlaKgIWSiH+OISpxhpfLt1CcJHXqqvJLEPvo6NJOwTT5i+EfgiuCvGH94v
 vmdIyUm2EAQxMs9b/UZ6HKfCyNXcOPq6nDEHXQQKHhk32VaE1KNv0RKinilslyV4IMSt
 JayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nzo7XXlf1TvFAdO72ji9ouH3fWFVK+LwFHWJE2tCDeg=;
 b=aeDr40w7OdIcOY8u5yDwSVjgZBq+73lD+IuC5RJIN3TubWxINRWnNK41jVbN3BhDIZ
 uDwil7P1g9LmA1kOshyuM/kDYhDY3PY35BB4M5wYSEme97wChwWy0jsTUXgzKkn8Bzfk
 +ilmkzb4GzzI8PUC9fnXGaS7Lc9DoYobT9SOTpPld8qy3GzpR7jwZUa854oF7glwo4z/
 D/kky0Bu8fTHAuqz6KJrKTncNpew5/EvufTF63Puw3lxMNXivfeak/bCGySf4a5PiaKh
 90IB3ettdDG+daAEHGsaRk1DLGTpmxUZe4gZw2LTvscwBQnA8mUJVg4s1i4ehd0Ul7KU
 1SuA==
X-Gm-Message-State: AHQUAuZ0yiLh6pyxZaeAXRUjxoG0nDVYb+oWwY8VZIRZiUzfBurY3je0
 pOBAzCQ/DD0Hw1qMqJgcZ7s=
X-Google-Smtp-Source: AHgI3IaHPdwxcsKYZxwkD6P1VoHg8MvwKwZ0vht2CbI9xj87Tcz0eyNVGsU7V3AS2ssiD4eECYYfPA==
X-Received: by 2002:adf:f181:: with SMTP id h1mr282736wro.95.1550062434970;
 Wed, 13 Feb 2019 04:53:54 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
 by smtp.gmail.com with ESMTPSA id f196sm2276838wme.36.2019.02.13.04.53.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 04:53:54 -0800 (PST)
Date: Wed, 13 Feb 2019 13:53:53 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Message-ID: <20190213125353.GI647@ulmo>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
In-Reply-To: <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_045357_052158_B7A71C77 
X-CRM114-Status: GOOD (  29.43  )
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
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============9032494133089508343=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============9032494133089508343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 11:50:12AM +0100, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - of_pwm_get()
> - pwm_get()
> - devm_ variants
> as it requires a reference to the device for the PWM consumer.
>=20
> [1] https://lkml.org/lkml/2019/2/5/770
>=20
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v3:
> - add struct device to of_get_pwm() arguments to handle device link from
>   there.
> ---
>  drivers/pwm/core.c  | 14 +++++++++++---
>  include/linux/pwm.h |  6 ++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..8cb5d4bc 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct dev=
ice_node *np)
> =20
>  /**
>   * of_pwm_get() - request a PWM via the PWM framework
> + * @dev: device for PWM consumer
>   * @np: device node to get the PWM from
>   * @con_id: consumer name
>   *
> @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct dev=
ice_node *np)
>   * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
>   * error code on failure.
>   */
> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
> +			      const char *con_id)
>  {
>  	struct pwm_device *pwm =3D NULL;
>  	struct of_phandle_args args;
> @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np,=
 const char *con_id)
>  	if (IS_ERR(pwm))
>  		goto put;
> =20
> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +		pr_debug("%s(): device link not added\n", __func__);

I think it's better to turn this into dev_dbg(dev, ...) and maybe
mention which supplier it failed to link to, something like:

	if (!device_link_add(...))
		dev_dbg(dev, "failed to create device link to %s\n",
			pwm->chip->dev);

Also, I wonder if this should perhaps be dev_err(). Under what
circumstances does this fail?

> +
>  	/*
>  	 * If a consumer name was not given, try to look it up from the
>  	 * "pwm-names" property if it exists. Otherwise use the name of
> @@ -771,7 +776,7 @@ struct pwm_device *pwm_get(struct device *dev, const =
char *con_id)
> =20
>  	/* look up via DT first */
>  	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> -		return of_pwm_get(dev->of_node, con_id);
> +		return of_pwm_get(dev, dev->of_node, con_id);
> =20
>  	/*
>  	 * We look up the provider in the static table typically provided by
> @@ -851,6 +856,9 @@ struct pwm_device *pwm_get(struct device *dev, const =
char *con_id)
>  	pwm->args.period =3D chosen->period;
>  	pwm->args.polarity =3D chosen->polarity;
> =20
> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +		pr_debug("%s(): device link not added\n", __func__);

Same here. Also: not sure if we really need to include __func__ in the
message.

> +
>  	return pwm;
>  }
>  EXPORT_SYMBOL_GPL(pwm_get);
> @@ -939,7 +947,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev=
, struct device_node *np,
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	pwm =3D of_pwm_get(np, con_id);
> +	pwm =3D of_pwm_get(dev, np, con_id);
>  	if (!IS_ERR(pwm)) {
>  		*ptr =3D pwm;
>  		devres_add(dev, ptr);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d5199b5..895e074 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm=
_chip *pc,
>  		const struct of_phandle_args *args);
> =20
>  struct pwm_device *pwm_get(struct device *dev, const char *con_id);
> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id=
);
> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
> +			      const char *con_id);

I'm slightly concerned about this. I think one of the reasons why this
was introduced was to allow code to get at the PWM if they didn't have
a struct device * available. However, it doesn't seem like there are any
users of that function, so this seems fine.

Thierry

>  void pwm_put(struct pwm_device *pwm);
> =20
>  struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
> @@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct devic=
e *dev,
>  	return ERR_PTR(-ENODEV);
>  }
> =20
> -static inline struct pwm_device *of_pwm_get(struct device_node *np,
> +static inline struct pwm_device *of_pwm_get(struct device *dev,
> +					    struct device_node *np,
>  					    const char *con_id)
>  {
>  	return ERR_PTR(-ENODEV);
> --=20
> 1.9.1
>=20

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkE2EACgkQ3SOs138+
s6GFRw//WfjZ4WWaTh2RR5S6JcMl98NKiUpTDAtZrDp3x9nyj+mesyPf/U3BI5Sw
cwccTz3axsu6UNGzSICWnFIFNFgkcprhzHSohDpTWfliLY9qDF2jGpE+GxnZlOmq
/jC6fWdZLU364U3AoZSlRGb4EP4soclPdkRN4GOUhLrc/RkvsWgXF8FyO9Ey/5/R
hZoLMgmsgoP200DcVFVcDp2ef43Q0NHKIvwxv2l7Khp1Yt+3jJ4QQkbijGbCLqNP
bFROfS1ycHYk19bQcAhzpUWfxkU2ITZ9MnV9AX8CQIveO4ircvxqUiC8kplED7jf
YOSz3+KNM72er/deev5gLOnmGF1RUM85PPCUbYDW9POHxdjRCyITyEix0zeTeDMc
nW8s7qmaaAaVnKlDx4r2SPrj1/KrMUs82iODOp1ceRsGX6lSLckmIlaZyz1yYTqQ
jRMUiu6bgb4YFODQ4LKLbZYicCmlTO1hXH9c7HbSmwiwk8Rl8t1i0qJctH2+hKct
a5JGR7XmV0QsLgq6kBHB0eFAtfxY21iolcSI1A+I1bxRPyEe+p2vsDd78cO9X+4f
9ApI2rAGWxK7fdLIHBMPwixuDfTtjVps4ku2ZcP8Bkhijfx/Yt5efc0JN2dhdmZQ
JmXhtskNozXeJvO3E9B86lr2Rgx8Ns79iNA15Ha17j3SpbDn8H0=
=+1n7
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--


--===============9032494133089508343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9032494133089508343==--

