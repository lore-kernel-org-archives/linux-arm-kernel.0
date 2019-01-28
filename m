Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7A6C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C045C2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ISrnOaaQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nigk6Sqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C045C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kJzzw+yI9wBYKUge3V0I4rw3k7gOGCQPYpPwAaFYRBA=; b=ISrnOaaQaWSi7cw+mRN1YOnE+
	+sQ/X/DXxOvxu6usor1LnA/UGJVI/KppjJgmgRbUxMH4EDyWRrYk3UT1lo/MRausAfpTidWc6e8zM
	MDM4gCE6A694lsxolUObHoWi0kL6F15U3CQz6UX3PBq2TM6Z6SzVMczteupu0d+utBmXoXnBJCmoq
	N1b9HHFkS1H0qOvVBi4yjrEiwTMKrwsCvkveZJ1syLinqS9mkrpiXVqsiozBF5yFeVT4elaZJYiBX
	UY5w8Ks6K+jcKWLFuSVqRAiaoRKZ35+H1MfT0cGamWm51ySnT8wWwCjV1MlKif7OyWSHx6Ew8pVKv
	xkgZITR/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9cZ-0003u2-3d; Mon, 28 Jan 2019 16:18:51 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9bw-0003Pe-Eh
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:18:16 +0000
Received: by mail-wm1-x32a.google.com with SMTP id a62so14627339wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ufeu8Lz+oaM8z+oyMCQG6BYxf2o0e3Wj1J9aKIiazgg=;
 b=nigk6SqsOR2Et16NRaPVAy4CATGAT1i5UvrYEsRDd0tT7uqbIxD9m/QkZaSWPntiGx
 lxXP9JS2niFAhv86xUxT9i5lP7VZx9p0pqFbczcpeNpko+qZJ/8joykP6kuhdHqKCNa8
 mxDs3WkILFFr2T+LkSvL/GFHAZuqqM7eqVgpPwtJ1orkeywWkO/y87fQ3jpWJx2+Riht
 s4lKAvIP89XBwBvYieA4WqWHj/uM1cBBwM3rSFjbjDe4M0o2LpDOSWP86UQ9lvJ1TGFs
 s9rxwAYmg7+jStCbzprK+skJpYtqTn6YmonfmgMTfLJi8o9Rhnl/fbi7Ash/BMea6A9S
 H0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ufeu8Lz+oaM8z+oyMCQG6BYxf2o0e3Wj1J9aKIiazgg=;
 b=FzJ8NajJO63goechEknuOE6+cXIPq7js+1RQLWpLlqH+U84+3s879+eotLrnPwvjZ5
 jo5XvhJ/Kzk4/pSNEzFaA5lbpPF+FSSoiozidls803uKgzBWRoIs8hvMNQR44gcBxNDi
 v9slSZgExRSQrllmYbDV9TRSLHL4e8KAxvg2EHIBwJOqVY2MTKsBeOsdVaZxTTqY8WMV
 A/9CaBhlS4jlZZQv5CQc8gwAY02AgRSXBBcP0UNv6/OTZEsydD7bulZt3U/cZNQiSLhc
 pLRtwBYkPgQ44crMeDWdes8cHV2taHSLLHtu+aBtomHIVq1/UxAQbovwFANiltSfU+vn
 eJPQ==
X-Gm-Message-State: AJcUukcomJ838c28Hzz66J0r1oNYz13LUZL05e/dXUBgBAPgdg71gP/d
 zEQL2K9ds2BbrhyOyZY5NeE=
X-Google-Smtp-Source: ALg8bN4cP3PCY9aMz9TpNOUgwQkMdbpe9WzpKc2Q3lmMyNffi5HX3gnSdt9D8hJ5wLT5BZ9Fd3XB4A==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr16989022wme.84.1548692288622; 
 Mon, 28 Jan 2019 08:18:08 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id d2sm93643621wrs.97.2019.01.28.08.18.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:18:07 -0800 (PST)
Date: Mon, 28 Jan 2019 17:18:07 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add support for PDA
 91-00156-A0 panel
Message-ID: <20190128161807.GI26200@ulmo>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_081812_623060_B2EB4324 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh+dt@kernel.org, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8770439496652504050=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8770439496652504050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:43:31AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Applied to drm-misc-next, thanks.

Thierry

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPKz4ACgkQ3SOs138+
s6GQ7A/6A40zNnOUXXz3Y+lz+5v+ncu7xHRZ6n0q11nJJ83TduEbkoCTQgLkqKy7
makLAI2kCDJsHqW+fdxxLNPEBV2njIPhSPzwLBEdbom+bGGICO2+3aGCuXQLe7wB
mNeTziTe529E7CCdC0SatoNzkRY1mph5jzX6mzvgLdIJ8NBrSOBJAriMc8LCi2ih
re6hNFdF/OpVxwn8t3mwGJL4Tl6PKUf/NGkEujoxzokEAv9+5J3Jv0nYkctDVFLj
KpkT8cAHaa2l4h+CMakmbk9kQmfr6138SSZcrH+KY2u9GihXQB1cntXnzTks/GAZ
1yGcHPqGhlG7fn94Lbyw03AvrFPkKYi9fUQdit9X6AIHg3OUZ9atgMt85ekr7Jzm
ZM9ohgrgAUGZ1FaGoOPAXLFE/EKFvQg6CZ3ji9eXaLceFHiisZzFu0JzfZL0YrQg
+TmoUNF8Y7cXbKfBMXTo0vt9aJaeo4HIkDl1+uUvjYZo+a+4cHEOQkzS45k3hXnX
Pif7g3C7fpWwF6avcPMHhZ9E8RXcaNYeisY4QiaWkNoidcZshTs1FOqVpeWm9owI
p42ah6cQLYtMj9xsKH61a4kWi9djQ0JzicWZUWfL366thRKXv4KYQ8wYKqsYCsV+
fxFtKD4ZHngM9siOCbWeG/wVatEx42nxF9Sl+zwf5DPtWVdX0ag=
=e/Qf
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--


--===============8770439496652504050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8770439496652504050==--

