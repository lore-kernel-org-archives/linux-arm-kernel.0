Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2240C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:45:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4049218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQBk0jj8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQjIBLag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4049218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X/e9V623dk1RtoPMeeko+kx+y2qyvCWA/2uG1MnaRqQ=; b=kQBk0jj8kxGOavI9OhsUvO9b/
	lsERC3jozeOrGhY4Bo8TMTjzM1I6CvuyKGV3YTvuxR5d9NAB8GjUOBtu0iYwtxKeKsxVIfpcZxo+B
	PHqApQGPkghOsdsLeF4jodF+OgBDA5/RguJNyBoO8iVc//b1vt+70vXXWXGUaINj8993F5vWNo2EI
	gqpmOfD/d0QUDfrnoTs255NdxhULDYxC8i2w/+DoWsACbjj3RFItU1F62/Bh3XH5hbAKIqI0hn60O
	Sp0DlcqohZPikiR5EkoQqoqmgoE0EZeyM2KGF9euBOhonAtoHwelhR1IM/qNYsdYMAcHIMlAIfQhi
	g8jYJkTsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzvF-0000ll-Tu; Fri, 25 Jan 2019 11:45:21 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzvC-0000lP-H0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:45:19 +0000
Received: by mail-wm1-x341.google.com with SMTP id y8so6316520wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RAlx1WqzSC7Krm+OXjleKqikUv91u8Yt/ZgajYItEIs=;
 b=GQjIBLag9uLRSRzZAop25ilLcDp9LSN4nkZ6Cf80be9YBVN/Sr+tv43HBjTi69QwoR
 iGqzXOmC2G5sEoShpa84dhBktsWrbwEoFGLYbga3ArMEHMl/29Q+OEjjhLQBwF07aV0z
 SGamtgwM1V++hZKmgtWmsGMkTfTahv0U+eQ21v+aK3mekhr7qMQ9QUAGWcbIpLl6c8CI
 eymO4NepxgL4u1iRf/iukjW6sm/j5+cB9l2gzjq5SxOrw2WEK5yjYmkElGEZT+qva+pT
 pSqskfjuoVz0oP13zgNmOHqypmQeiOVXyBHrfWhV+THSYEqacEXzZXPvDz2e2Py6+7NZ
 cCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RAlx1WqzSC7Krm+OXjleKqikUv91u8Yt/ZgajYItEIs=;
 b=pEQeYQuNKYqqqslPovxmtyHL4xtmGYbvUaS23QprQJzmy1oy9GlCnvtAm2+vWYqaWN
 umxgGIVOpA59Kbf6NC9WcuIx7jDfsqzm8vcmu96LHxubpslaoyugsxBb7zEURS4eUpoK
 UF93XaKgTL9sns6Gr718DnGn3KMbFBGKNW2uLi9WKCHCpnhVb6/B+xOenuZ0BZbB5RJa
 NdLE1rypb9mbwugDXPmJrk5kbCnPjoi926niif4wLq3/R9tpBku8TUBfJUhDTVY7c/um
 zSlL7K0JIuNUt3OQmnPmcqfTYExvhVErBbh2Qr1MSsSgx4wfilWrHQZc7NK9wFf3VSof
 g+nQ==
X-Gm-Message-State: AJcUukfx8UhCK6NWw5efupgOLzbX4Ln+TorUcWkkIwow0gwDCa3K+0SD
 bWL4x34O14rUbGJqT6FIwztGlTfYAI4=
X-Google-Smtp-Source: ALg8bN59dlHRZ8MU0fGTcT08sLlv5nmvjK5njumbtO2sJMN7QiWna5n6HbEC3OTd7Uk03vgGbZyU9Q==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr6534754wmy.92.1548416716910;
 Fri, 25 Jan 2019 03:45:16 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id 200sm66133004wmw.31.2019.01.25.03.45.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 03:45:15 -0800 (PST)
Date: Fri, 25 Jan 2019 12:45:14 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] soc/tegra: fuse: fix typo in tegra210_init_speedo_data
Message-ID: <20190125114514.GA12353@ulmo>
References: <20190104071646.15828-1-josephl@nvidia.com>
 <20190104071646.15828-3-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190104071646.15828-3-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_034518_598932_02450E5C 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============2742746896377470155=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2742746896377470155==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 03:16:46PM +0800, Joseph Lo wrote:
> Fix typo when reading SoC speedo value from fuse SoC speedo register.
>=20
> Reported-by: Mark Zhang <markz@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/speedo-tegra210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-5.1/soc, thanks.

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxK9sgACgkQ3SOs138+
s6F/4w/+OOjIwvCIOMFyAIK+rcqXFPPOUo0KtJ/dVNvK56BGhWSNbi21FtbO6MxY
50xzifCrSqLR1tTDwLof3OXg9Ew0/dg+e8Hh+STyPvjel6u8zkHMBcLTfdAu/+cd
CEj/pyeSr8yxGrpZJVw10BuTt7/qfKcJWzvGc2HiuBhgi9BfSqIUgo5r9Hyhuhom
W84g46Bgi9yo5wJi+tkVhtBgHkNOoBxX/m+2Fdej6lZCVkDYaw7J3vxiB+UKP+3W
RK0gl8V2nrvC26kov/AGzPy912/3AmgPmTqR8xZTSnmBEnq1TAGO3ffG2X076bJ5
a/ECnD6rorwAPkI2GAW80bAx6Pg9C5ORbRF9+NQa3fqHn1VaplCajJ3+5fkbGwPF
SsGrFyoi8fmdQSNS7/ao/EMj2HqszOc1usJCoc8fKZVUuiN/NH3SnXPp8p79rePD
fLuMYW0/8DN0ULoRGZ/aTNWCsLvkvkfx/y9QzJKVgDwnXZyolWXmTgs8FiZ2irvz
KxGBvWJkRJPSs8vKXTenvl8SHWvv383o9V7AvBdv3ywLbPIlbaLkKtxnEx6a7Ipo
BFdyivyvrziN8+9mKVweH/cKC/XZSPVtEk5lp5cFmIsokJrMXtbtacWiviWFoUsl
oT2H55vytZCsizJdqg8x3715yddZvbinvtjknjwAeOg5o44dNuM=
=Jd6c
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


--===============2742746896377470155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2742746896377470155==--

