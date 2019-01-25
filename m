Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:03:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86852218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k+H73Dus";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK1rtnDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86852218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cI9sBJ5iZmkwL38ydh6Wm8zODC5UmgJXG/ljkmODfY4=; b=k+H73DuseSMfT/Z1M8SV70bVe
	GbEjjcptSC56wortpAJReEgrtgEOI4KYZ3xIG4Vgigwwn0JE5TNSjow7DgqjqM0xudx5anGhuEwS1
	JT+5CEyq70aq1xjPMCz1NpzQzMThPaZDXA78GPArY300iJEDjYPkyWrV7pGvBTKphFTm//ZdUqNvs
	ba0qL+2s1LA3+SLE/N8npmsxuKjOpB0Xbd13VSYCmX6aF7sl4eVPyAAdwOCf1FRidPclugg6AOWMR
	Uge9Ybd0vb1VCdHeuavs6m5qa/7MJF6Psxz9+AWi3+enu9gNNeZJRpUSpQje65HxqowAs136oYN8j
	AScNNtRyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0Cg-0006zv-K2; Fri, 25 Jan 2019 12:03:22 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0Cd-0006za-E5
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:03:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so6450107wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gsBTbZFfU261is/rIY5R4OWPxkYM3KVSKnxz90vOseA=;
 b=TK1rtnDlKzEIl7Pp30n/U8tFwF4z1Vg/QRRBLqVKvLe2a+u7aA7pbV0dLRcILxQPgG
 iw/JgrWbrVCkOYxO/V9+Rw6ALg3dPIrkKReeEhcR9iZgIZGkc/S8+N/6fimNbnIaF3ai
 yenNF4LWRcbDGKeabFvAM6+kLfFNKhH/M3yjPMI14rVmMcP82UAEG065OxCoTQ92In+O
 RKe4BScbNA2mbXcLDzKYWPHPqfF4AHuSLqlHU0jfxkXwCwJAWJBAT4+ZJc8YQVI5Wybs
 HDPU90D/PDo+VfJeYoCwfRLDTx0dSuec44FDY/K1NCVB1A+Yt1qzE4XhZIhp0S3mxZ5v
 Tr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gsBTbZFfU261is/rIY5R4OWPxkYM3KVSKnxz90vOseA=;
 b=f2y4MfdPgobSVYzHdDx79OHM7JjhDDwTFnxVmaZ4pWYxiHmQ4o+8c9PcC5u+pVDoAj
 tquB+CC+1zJp6faJRkuSs/1yvS+Tfo1WaCHSiSZpnIfEa8QwskqrMveBuaturp0IJKzF
 p7q2Xpbk2IEc9LZssE+Zqmvzx0jlTrSrYdF2TfXZQYtPf2N2AY9+md9jMRzzzYChLElC
 GumroUZw0rG1v1UnvYk77uafCDRRJoIgNxhNnPPD4HVBQuZt3Jji+w+XAnPSy5C6hXd1
 XkOuyVK1FGJBQ6blr1hC9hL+YvH+3gLem0hf3JNF850HiEkZSUNUnmToTtUryKEnlA/L
 qurg==
X-Gm-Message-State: AJcUukdRJh3lM7xNQnQcV4sqVPjp4ATv2rQ2EwqqIwPWkA5KFOnrkOIy
 /T5cmChUAQLP/JoCFcE6ugo=
X-Google-Smtp-Source: ALg8bN56OIxALc94F2g4B/+baEXDTUzH9M1m1bcaX0P7/41sSxjd6uabOAAS9yCqS+KfJDUTN+f7Nw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr6887949wmf.38.1548417797956; 
 Fri, 25 Jan 2019 04:03:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id c1sm51269720wmb.14.2019.01.25.04.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 04:03:17 -0800 (PST)
Date: Fri, 25 Jan 2019 13:03:16 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] arm64: dts: tegra210-smaug: fix IRQ type of PMIC
Message-ID: <20190125120316.GD12353@ulmo>
References: <20190104071646.15828-1-josephl@nvidia.com>
 <20190104071646.15828-2-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190104071646.15828-2-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_040319_474639_73681A7D 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="===============0889917863182305958=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0889917863182305958==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 03:16:45PM +0800, Joseph Lo wrote:
> Fix IRQ type of PMIC which should be configured as high-level trigger.
>=20
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/b=
oot/dts/nvidia/tegra210-smaug.dts
> index c08c5471b974..5a67890cfb7a 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -1362,7 +1362,7 @@
>  		max77620: max77620@3c {
>  			compatible =3D "maxim,max77620";
>  			reg =3D <0x3c>;
> -			interrupts =3D <0 86 IRQ_TYPE_NONE>;
> +			interrupts =3D <0 86 IRQ_TYPE_LEVEL_HIGH>;

Applied to for-5.1/arm64/dt, thanks.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxK+wQACgkQ3SOs138+
s6E5PQ//dAz9UJjbVba6RxO169pcE5EHPckO9PWifyggQSznb7GsS2wNRmt+riKs
bPSFBbQG+FHETwT6n57vzuWpyxWvJfbtbSujYxvwhd9sV1znAfXViImMMt0zB76K
q0z8AfYsMnjIjdkxCoIAnmOWo6ofTiiwtCnesCpehKcfmgfQ9VqybR6e26dA+Emo
kbKusiEprqkJRu7JPplgC22VvNQzEdEJJmY2BvRy7rOHYh19/3reE3ANWGHtJt09
YXSGbejb6onQC/aQ/jSWyCciX/U7B/wd/6P9XvCVVMr/jpuA5W0BEKg6ADS29jWp
oDhMVXujt6WgFTpK+YgnDfZFLzXxUftGuJ06WG2G8woTnshCzUho1w+17+dq5Bxv
csC0aKwb6u1z5kMkxk/Xq+spUv6oYs59cKv+D0D38xeus0tRbnMUGbHETARkkgrh
nZHX7rdmgA9sU6iebmTiwp7+bNOl2KSOwnGQs4oI6TnjYBkGLwlDNkbpapvEJEeo
FT5s2YapLJLOz0pqyYoEQm8mEEFxK8/FB8L49LOdU/6AOdpHlrRRs4DU+ZRXE+M1
2IBRwg7yLkSwMUrvNQctjVJz0vcqMlZcIO4nX4E1EmB/hc0KuQ+gy9GpH7aCQg3n
kWR08j2w2ocPpKBvzagUDRd0+AWLH5NpHtwY6ZFZ0d+Knb8gIpc=
=zfze
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--


--===============0889917863182305958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0889917863182305958==--

