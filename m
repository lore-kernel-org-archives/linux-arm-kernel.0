Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE867C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9C32082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UCiwEqnF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW3BJnV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9C32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pZZzaDAV/chJqI1kvIMbtK1q9CPhlO0AhDauh2rwllQ=; b=UCiwEqnFomf2TbW10qn42zKYl
	gZCeno46TcGEzLswL/WBvOOuVZ5DxgB1V6fSR9AE2CY8X6xEh/baIfL2CwuFCAt2jjTYyv9VKRnmC
	Df6/QszV0hqF+dzjdkM73PPhCOIlaLh8k2aUkWjUULAad8pR6XMMtiHH9xP47+Ku7ornT3l5FBFaR
	SDuMlXR3H1rKmey1J3nMJrXMN+DlErlMmefF5cVYVBZ5DQJeYTAOqSEmAEvHUvWbebJ+tUcpYROlK
	Aky3FJyx3CH3IaLe1X7MJZhUvBm+x/SoukYTTd4X2P14BqkETR4kITCXwp4yrv1jdx1whOuBveWpw
	u9LMxVymw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9Kk-0001by-SE; Mon, 28 Jan 2019 16:00:26 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9KV-0000YS-IO
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:00:17 +0000
Received: by mail-wr1-x441.google.com with SMTP id u4so18651072wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rAf5KtiLxB+Y8yeddfolVuZO/p4Rej1EROwoeD/HCh4=;
 b=WW3BJnV2TgZkYA7Mks7exD3nnMDX21lD9e0moEQJ0rTGE0ejhICthxrjfvGbf1bFwn
 GCX4yvyczRsCz/PCafWqcLuodsrJ5bErJzoTYJMP18Yc4xw3lnU5j32ASh9rdNsQT/BP
 YB6L6lK2DQ72feI3bHLx1Vor6dBJpMumU+IKC2DVe/ftAl48z1wva9j05QWIQTV1AERZ
 zUPFn8WuoXzZQ/hkCs7/QQuEzHYi2FAjjW3zieQLj0lSV3038hkgt/8B+cHEZvLVEfqb
 2n/TmTZyajLKF5ZH+D4Gf4MLNx7Hpb2rHNoETQkcLkPr40eS4NEaRZ/0sBbYsgxVZATA
 zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rAf5KtiLxB+Y8yeddfolVuZO/p4Rej1EROwoeD/HCh4=;
 b=UAzRklQOKvBn6A+c7yC0U38J1Cgh4l7GK/GtCAlCDOg41RWcdFnJb/Meb4mxYZsi/7
 lI5zbARzH+fGgoAdjXmKROHvioL63kgh3GMY8s2WZ6AHoPDN+J6K2aOzuG0uIN9Eiswz
 1DKQItPRgjpzUx7fFsxiZyFFq29kRcVht0TXbHcVfgQz8OSMwRAUGfSEpHnITencKvbG
 ld6tfSuteBYEWakM1GxU30jKrz4pHcmj9Fd3ryuMakShm7BY8ullvbzxwNjNt5OpAOxt
 iAwdo9+yXhTCEMb7GT+6a14+nWHyX9cmZV7LByDiSEVUNB+OyLqZ9n0JZWwPcEDVE82i
 BhCQ==
X-Gm-Message-State: AJcUukec1AvDUHPACipns/6g/IMcH/4vg0SsjxIdygkm9lLHIry7Dxjz
 ge1/VKQiGDIVKsSQLwhHMQM=
X-Google-Smtp-Source: ALg8bN5pWnMJYEHDDziducx0SUj6LBoU4btuuFyq0iC9SAkRJPub3QntuNyHUtWJNFfYq0n26gY3VQ==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr21687810wrw.310.1548691209769; 
 Mon, 28 Jan 2019 08:00:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id b12sm88642813wrt.17.2019.01.28.08.00.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 08:00:08 -0800 (PST)
Date: Mon, 28 Jan 2019 17:00:07 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v3 4/8] dt-bindings: Add vendor prefix for LeMaker
Message-ID: <20190128160007.GD26200@ulmo>
References: <20181107181843.27628-1-contact@paulk.fr>
 <20181107181843.27628-5-contact@paulk.fr>
MIME-Version: 1.0
In-Reply-To: <20181107181843.27628-5-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_080014_934041_E354BB27 
X-CRM114-Status: GOOD (  14.40  )
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
Content-Type: multipart/mixed; boundary="===============1958096333074213179=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1958096333074213179==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 07:18:39PM +0100, Paul Kocialkowski wrote:
> This introduces a new device-tree binding vendor prefix for Shenzhen
> LeMaker Technology Co., Ltd.
>=20
> This vendor was already in use but it was not documented until now.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Reviewed-by: Rob Hering <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to drm-misc-next, thanks.

Thierry

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJwcACgkQ3SOs138+
s6FAihAAg3SFG5bkiqSyuBFogMyx2ezKdKZLxO4g3NAM6DhO3MKV/iyCCpbcxeaT
L0YP13yjuhvOc3JdiX9H3OInqH4pUV2ybUPZ3RoVVgB/LTWxth+m61vg4S95kLbW
801yEJqXxqHLSNX3jzZby9n6wKC5ojCDBTa0nggFlKKL/XIkFNAWIuf9S78cUPoG
si4+xZf6tIftd8F3YYQLsTlfA/dTqTwJ4oBYOoH+W9DhgamxRV+DwwNfRpHy4JbJ
cVs9tce+OhdZL9W/l8aisfq2TQtbctfEbFg+NjQq3z4y2HRk2jz5mWbtkhHDn198
5Kew52EKWfxIydnJURrPtzGjF0gn27uHZaKAxhYNW8qTRnuQjzAJSey6sopsi15h
nElhgiLK4yW86w5CO0sxtM+4Rn7FUHfgZP2ek8Uff496goaKvdJJqaD953HPDy9V
FGLUKkekd28xLRrkuAKGwS5oXdLisCsckQZU3Wq/7NrxziudZvE8UxqoGrriYmZd
//QZM5BWnc1T5+9bpfGXD6XsB5mY16wCy0VZulE4tLcBsltNDCt8ywHuJFvm+Scn
Ujih/S4DGcALpvfmGABk5nKb9n9uLP+C54N5opmvCrKbRX+2ZfY4fvppkIed+fQ6
dRfzEEQEvKVi2zROggB+McIp9Z+UtXLsjGapHbPgRYJpZ5fTmxM=
=U+8k
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--


--===============1958096333074213179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1958096333074213179==--

