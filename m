Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7ABC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB91821916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pUd5E9Qg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZII5RgcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB91821916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=01L2hkhEB/ANdxdMcTt9RVts0nWwEa7kSQTCw9D4znQ=; b=pUd5E9QgcOd8y7eeP2XcfMqxl
	qu1hVHkO8Iz5EMz8vQ/+k1h6ZKMmuTYCOtmw06r+0ucDfmxze3IVkHStL8d2VP4CixWhimXABJRrf
	YChly0O/9L5Y791BbNwNA+3Q5dTeTQBcjn5T52+HCRTkMvp7+aqoQlbRcLgV+TY+0CleCn2osDcv0
	vAufrPu/62HpaXElapd40e9T7CacWoA8Z8XlpzdvBpqWiEgQukwQKQcze+WTxbLpPUzVybLoKsQk8
	xUNB4PIo6jW5X2rNkY6aRJCGG179xWEoM4hHDEuSd7n5+n9ZGapEEkEmLZRafTZRQP0rC4vMzqSXa
	UaQqv7yRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9MB-000254-7r; Mon, 28 Jan 2019 16:01:55 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9L4-0001um-Fa
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:00:49 +0000
Received: by mail-wm1-x343.google.com with SMTP id t200so14584616wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=I4uG06dG22XIYOZRNcXMuXWea70R1YziaVKqVrG4pJs=;
 b=ZII5RgcVh6j3e0igq+Yr9pVJ7Pbmpp07beofRINjaWQeAq2+saYbi7Lg78G0IR2zSs
 98H4u5teZDDYPKjrBImsv38X9BNXK8btfWwNKxbXnX9LPTn+Hs/W858FtJOHDNJerqdO
 gG8vj3kyUQskroqXWSfBC95I7PuXJoPUElHjdi9KTvcBInpswfy20pgBpiLRTPyC4JxO
 dEX6NKHNKxfHnfm9AHeLa/HIYeF19tI3fgXhmBcs6MbCNwOgKqyss105TNwDrhnI0UJf
 PaPTLbKMXug4mriKxZkoGf+bkeuRgwlzANPfBMLmwX3BbApT4qqnSBZ2yLvNfpmQaHzZ
 v0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=I4uG06dG22XIYOZRNcXMuXWea70R1YziaVKqVrG4pJs=;
 b=Qby0i2uivqhKi+XnY77pc3uGga0K3bSRm1Xy8qaAcNUvTWlYK3AhNCTCn5w3HHuENL
 b2FHzJbSgGd3lQbrGYFpW2Sk8rKwVKwObXRkpq5iC+j3ONMJTPoc+hwUF57YvzUvGyxa
 oT8jmkm6SRw2otNA5S5yDX7oZx4QARQW16wBtbPeejlRV1Jk5oJ8xXMIY/9NvuKypQ1g
 Wr6ab1S/pCRmraJ0GlbXuRqtduDcrZnnJaFzUgoqfyDSnTyb79y+TyS+t7TA8jeF8A/K
 PslRsBut8L9JIPFGoQ8cWQwSoiwulsOoZ5q/SDPHWqwFsPEB4ZvkkoU2HyOwA47B87jO
 1fsQ==
X-Gm-Message-State: AJcUukdzELE+70E9amTqSvEHiXHGwup0FxXCbx8W0GtICy1gjEDCTRuo
 GvfWqC38BK1WRwUlUq9zBXo=
X-Google-Smtp-Source: ALg8bN4HnQgdHo6Dt6RibKuiaZXkXktjoOtMGMXFQlTydeMDLvzSqBR27uRohMR7lPB1jRVI6ChtdQ==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr18797991wmi.7.1548691244871; 
 Mon, 28 Jan 2019 08:00:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id k128sm104129573wmd.37.2019.01.28.08.00.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:00:44 -0800 (PST)
Date: Mon, 28 Jan 2019 17:00:43 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v3 5/8] dt-bindings: Add bindings for the LeMaker
 BL035-RGB-002 LCD panel
Message-ID: <20190128160043.GE26200@ulmo>
References: <20181107181843.27628-1-contact@paulk.fr>
 <20181107181843.27628-6-contact@paulk.fr>
MIME-Version: 1.0
In-Reply-To: <20181107181843.27628-6-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_080046_655688_E1F62414 
X-CRM114-Status: GOOD (  13.60  )
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
 Mark Van den Borre <mark@fosdem.org>, Gerry Demaret <gerry@fosdem.org>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Luc Verhaegen <libv@skynet.be>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7124803257998341352=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7124803257998341352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:40PM +0100, Paul Kocialkowski wrote:
> This adds the device-tree bindings for the LeMaker BL035-RGB-002 3.5"
> QVGA TFT LCD panel, compatible with simple-panel.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../bindings/display/panel/lemaker,bl035-rgb-002.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lemak=
er,bl035-rgb-002.txt

Applied to drm-misc-next, thanks.

Thierry

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJysACgkQ3SOs138+
s6HoIQ/+O1YFHBC8AzyCahNnepV+kFaXjBypJm3egi893Jxt/qHngldQkRnnx9AM
GaZszuci46ensRLTwhia3HQ1lyYkD24v8zZ62uecemKtSWsL+uN0fvWIq4WYFzPO
UTfHX7yRfMUFyC4qEXAqVm6U/nVvHSu7trzcK0wzBgZ5NpseeQLcDAyuL9mPTmsW
bYlFR+ZfW9sz77JvUNY3Q0e5YjAeC5tMOSbro0SdXKh7JukDd1sCAVlOBflyuB7C
TYmrn7ONpXgBwT68vnpNJNBnBN3mMxwDa2dbOo0HnZ5q9YixIT7G8p6nAkW9eflT
b0ygrXtj2/4QZSdtM1eYuUCSyrkw7CHkP+98uWS4KDkEyH8EBw6LH1SgN2KAbY9J
k4BNAtInQqDg9ZVeemZ3V/B6C6iMNzimdSUeUIOo2D5jNtD50X4fVT5HgbUTgxN0
WRg7QiS34hlJeFdl0UI+LQwoObFc5T+edqpP3CEURh61MM+At9nXN9xzK34Z+mRe
6XSej5we30hzStX9/mi27soX8ZTiH5efWL+GnYqABJignAsZZlg4PYMUJx7jtZG0
KUE493VchKHKLZ8SWyGVL7FSUNPZ8lnA8EZf6ZI2xShMoYz/kg6XyNjNkuyBFXLM
06PAlYemA7UjQT/o8LTzYxGXpCYlekBVNtqQasPqDern8hg9IC8=
=jyXv
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--


--===============7124803257998341352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7124803257998341352==--

