Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C148C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:44:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A8C20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TKAhkZ/i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBTZqmUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A8C20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7hcLj5I8lEltpBz72sHW5mti8gZ8taTqQKuZwrAXH0U=; b=TKAhkZ/i8G58qhBAMbp3nWdQk
	Ai/PCUu4OUxotASVh1AnuWyRniG1L5bUqtSQkYJ541iYxtK1Cv2o1EERmsxXhj5cefl1+y16n49Uc
	L5OFzzvzdfv/S9S7Z8K5+8V1MlKfeOIDivAHz4h8AWiO+/VnnoEZp/1iz6N0maR64vkydvP4KSrgQ
	AO8bHGE+/09G4RWsQveHgs5akd631Anxh83eAZ/L73bL6JGEIbowsxuxnHxjbdaT+Tt8yQ7xbprPv
	ZM18aBy3JgVhNU7m1jnFqQpYRVOtqtDLXy438hur5sEhCjVh0ZxaLJPCKfdOYc00WLmFTP0964Ydp
	gw+hP4l0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqYv7-0007EN-DA; Mon, 04 Feb 2019 07:43:57 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqYv4-0007Dv-8e
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 07:43:55 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so13252290wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 23:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vliFUfzvOXC2NEgNssi68Oi7wqr8mF99aTHDz9ZyXvw=;
 b=WBTZqmUatsotVABEop2Mc0WXn+dC8zE4OU6eU7VIzf9/743kZUX2AmV+kMLE1mLZng
 kAzlFx3cjHwmYiDVJwpssesUOzUP4Gi8ARTCbNxLE6u1Xtaj5jCc8o6yQlHx80Bo+h0R
 FFNIgFobucTbKL2FApg6PRHHTLa0cFH6gz5QgtAuL/q+EKgN5oHAUN+gkEyyTNHJRe78
 GoZi6iocJEQkEn1XGosQ7DrvxpSE4TXjmOvQVmBAdH5ezZhmuoD1n2sNYxovHWhWU0kb
 O+AXH3czylFP3SWEHAat+Hy1HzqBypIj5rc3EBAHmoa9mi/QshOV/91CUA0FELUH6D+r
 JdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vliFUfzvOXC2NEgNssi68Oi7wqr8mF99aTHDz9ZyXvw=;
 b=B+qXAcXzT+VZG8veJYFozsJOMoI+0+XRU4XODnen/pt+C9ahaRrHHJNafFx//Qto5V
 8OmjKhM7spEm1Fcf0ujvL029tvC1rnLQCsTQf7urfQii9VGmrZLZntAVY2sMMLf4S2M9
 VnRY+bSYZmNYi2154il+MpO6asHyyRss8x2rFVC712MqNDDuAuvQZux+zac9HX8W+6A4
 7chjBsxwTgk5AfgOe26Mj47svQYpKgeb/Xa0rbvK+ovq3hcQad1bWCEpNvxyW4Nc+uG3
 HuyN5XrXfzbZih6glYTUYdxeas2allQvl/4nkPUs8BqCG4t4xcdAEDZfYLQL6PCmZkOM
 qeCg==
X-Gm-Message-State: AJcUukdFZfqK41mjljIlP9pbON/zOf+oV0NhQ3XFFev+ZxrYc36FRdb0
 /dhur2/A/ezlvLP+YKZbqE0=
X-Google-Smtp-Source: ALg8bN44cvi83OcTQlGkQStdPh0aofhmQe8P2noyV8bDzY1pIxm6+NNV0Ecyv5Fr2QddBGZPHnFFdQ==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr45933490wrt.37.1549266231856; 
 Sun, 03 Feb 2019 23:43:51 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id v9sm10954871wrt.82.2019.02.03.23.43.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 23:43:50 -0800 (PST)
Date: Mon, 4 Feb 2019 08:43:50 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204074350.GC16448@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190203185501.8958-9-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_234354_332061_6050AEAF 
X-CRM114-Status: GOOD (  15.55  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 dri-devel@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============5652351163031009928=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5652351163031009928==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> eDP panels usually have EDID EEPROM, so there's no need to define panel
> width/height or any modes/timings in dts. But this panel still may have
> regulator and/or backlight.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel=
-edp.txt

Please don't try to make panels look more generic than they really are.
You're going to have to provide a compatible string for your device that
is more specific than "panel-edp". You claim that you don't need any
extra information that is panel specific, but you don't know that now.
We have in the past thought that we didn't need things like prepare
delay, but then we ran into situations where we did need them.

Just do what everybody else does. Provide a specific compatible string
and match on that in the panel-simple driver. Even if you can read all
the video timings from an EDID EEPROM, you can still provide a mode in
the panel descriptor to serve as a fallback if for example the EEPROM
is faulty on some device.

Thierry

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX7TMACgkQ3SOs138+
s6F/bQ//c+qCVWS1yJiXH4j2lfwm4QZOIGm1mCBi3Web8x9m9R94WHfmJeHCfjEq
QXMT7a7BeOdrFHod46p9seiubiljPPy0loPEeWx+PhlYU5Kqa6/eHgWjVldcLB/Z
sviKCjuqG8xs/yeJEOuqNauguIkwJNtvLHad7nXdy5WTZylZVbM/nZoK2o30tQ4e
HKW3Jjd7oz1EXLYA23h1c5ZddXB6yZKVuGSvvjn+vMw/BD5OR4QlPS3fpo/JAKyI
Y+olB+WFFMA4dD1vkAZnBobk2TAMwfd9llyKpY0ReFUupcyI0tmV9sJTwj5ynQrp
KezusmR99iYVTMTALOIci4ldZjHL0YXWop5J5QFJltzmX6DcQtW84dWNsLrh0hUH
gnz/xa36xCVD2WVcjqvfy4QId1O1f13Y7xTqtWu8fTohpaQQCoBpq7uAPVkvstin
AE4pdHoYygvaU0ZXbSOQ2a53C5xwXXup9njT2x1ihFD1zfXLlPn3l/5UEIj2VxuC
sGhQu4D1oVjcYB7+s5vnLkg9YoNPlmp5pD8GES5epML+lr0ccnlGmVNQUubHkY0V
c9K/9vWdU6Noj7wHY00bbOSykdD0Y+OO031S5myEjO0/PW+OiWHWEdOK34Vg6rgC
ZWh3gTDDQbjCzj6OzJsWhQwp7g+kubIHN9jaqORdUv1aUxsU6W8=
=LebG
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--


--===============5652351163031009928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5652351163031009928==--

