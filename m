Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA0C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:15:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B286B218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h7Tum/ZI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1eQ/kpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B286B218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MSlx1gyS6Q7ASonvvWw/EC07ZUOmSSOVPI/52nw/0Q0=; b=h7Tum/ZIw3AJxVKLn+60lXxZJ
	JDT4SWTNWEx1lixMtlBKfDCAl6RB+TqBLknp1Of97Z4Omb7qOIH4mAnTtEu3Z/5gc5UlkALqUc1Rk
	Q3KahMgXXoNmkm4/HYR3QxUThVoMjtyiH3kj5U5B0groWQbnRBdRL9JjXwcZIE9vWY3l22ry/lUdn
	Kngr+ZawqBnC1oxDqAG/raMdZZ5TwF4YXVGawayN2+7140o6vWVLVD+X8Jr52kFSgUbB2hC1x0wb7
	VNxSLzC1i4Um90Y001TCeziBrXHdIXUcEU17LNAQ/GpQj4eHvSjSTnokDNWk5CW9xY/AH/afRG5ip
	DihD34UGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3CD-0007RJ-0n; Fri, 25 Jan 2019 15:15:05 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3C8-0006zI-Pw; Fri, 25 Jan 2019 15:15:02 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so10680360wrt.7;
 Fri, 25 Jan 2019 07:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Y52cIatgXj9ncOhBi09+EBvCaRQ0mWTjQyMl82EKUig=;
 b=b1eQ/kpV2pdUbzwJllWiBtGT+q8UoOYbntlD36E6wetI6Juyc/dFLU05Ayzu90hnSR
 /K+4+Gnuex8oSVvYv8p/ayWr+p7Nxds++WFnkG8/jqU8feXY3vPXARimL/yKojzpjH5i
 R5QVNHIoY2URozKCaAf6eaE8JNku6qqx25gvd0rTMhy1Hmg6KZqBDlpTcf/Rm+DxUPBp
 9shxZ2pynlJTjOTlZrWwHe5yqjpN7eR4C/NJjiTG8ezxY7oySft+jdYR6o1hjhrgSvSN
 HpsHxNPgUY+X0mWBM4v226fCzQkOhmXw34m38EjLIWWRGivr7FoVmpA2YILIdngYbgH7
 lFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Y52cIatgXj9ncOhBi09+EBvCaRQ0mWTjQyMl82EKUig=;
 b=kRvK2yUJKZ0o3say90p/LKWVrz5xFIgD36K1WpO/OJjjxR8JrdJ31WdHdpI2dF6G9c
 AfmueqElFC4Qj/3uldHSb6fmYEP4GRnXHqlzftIo4uTAA5ItZtuRTpUoU39c/i9FlI0u
 aL0MHaBqDjT4Ze4x9htzZnb5fSBwHgiYGpIS0Upc409gKNT8vhJjU0hCsS8TJA+12LKQ
 tZAuii/v8/trC2mA05gIE61qPGg5Q1IbG2CBfQEAqgJXkUC4KHSLuFNDjkIZW8IRZFDd
 hnU9fXLnhswL63+f73Qs/bgzt8rpx5uio7PUqQDzsuErKOyA8ZRqqDBbzaVFidL0zG+W
 wNxg==
X-Gm-Message-State: AJcUukdYkdmMKX70rHt4YKuwWX3lAFKs9XhtNOBH/77Pgh0vQTBklKJ4
 yP/fro6blV/GOz7Dgxr91M4=
X-Google-Smtp-Source: ALg8bN4e/Y/iZ/lJ6hkX7etNhkHidDPRqc1qK3xTq6uM6QGnfLuLgTMUGgWrwsApr1EgombU9U5VzQ==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr11291961wrj.91.1548429298076; 
 Fri, 25 Jan 2019 07:14:58 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id t12sm101705524wrr.65.2019.01.25.07.14.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 07:14:57 -0800 (PST)
Date: Fri, 25 Jan 2019 16:14:56 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 26/26] drm/<drivers>: Don't set FBINFO_(FLAG_)DEFAULT
Message-ID: <20190125151456.GH22565@ulmo>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-27-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
In-Reply-To: <20190124165831.16427-27-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_071500_840806_FB207C14 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 nouveau@lists.freedesktop.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Kukjin Kim <kgene@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
 Alexander Kapshuk <alexander.kapshuk@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Inki Dae <inki.dae@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: multipart/mixed; boundary="===============2519851863857611000=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2519851863857611000==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 05:58:31PM +0100, Daniel Vetter wrote:
> It's 0.
>=20
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St=C3=BCbner" <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c     | 1 -
>  drivers/gpu/drm/gma500/framebuffer.c          | 1 -
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c       | 4 ++--
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 1 -
>  drivers/gpu/drm/tegra/fb.c                    | 1 -
>  5 files changed, 2 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxLJ+8ACgkQ3SOs138+
s6E2bRAAhRYy7WfmBsgjqoiAMMHSr15GvFfQbzkmu4PR/tZJzkyKt3OP7dvd4PXa
UohlRCdaHb1zK31yggqH2uEwjPofvI5I42CH7f5xumRAac/qvD+nIrP9Gk6zTq5I
RifQVtlbfoUm7n29P8Ba/Yt+SFIP9BmkmFvIfp01jWI6mv3U/tryVcZFYtmeGVER
/YFUimi9k0MdpqkMkAGVBx4m31BLxYYjuK4lYqcQDksN45DEA6jUSzZbpxPrbE/N
v+x9LTVFLRY2KN5G8ZNknnbzj+6dZSHBhFbhp/pREUIchSzR5sBtqOV1Xj4DOp1C
uMsgQLZk3p/yeHf7K1UTHvCkzWWZrnyePhYN1da2DOK1ZQhLT3+vSBv67PuE79eD
B3tVzcxR65o25af3TXrPTjEaG1ft8/G70o+30rLtvCuFT2xd31+dnnXjhOakVR83
CowTRTsDR0j5OwpE8Y1VFy07qsbWvHNg0xCl++Qnz1aMfQvKvL9FMB0/aNdfWd3v
WmyAzCOwydnsPBh6FG/J0UkPJMgWUAOQq+tLxc6KIgBiKEjk6P9+O/vsfLD9YsTn
Sm3rtZcpHrxV/BAiaROKWcoCH25gPccSqewlDwF6w2JIs6CSG0KZhsA43fMZV6Qb
RZ/glm0h539iZ3fsWoQ0pAP7EeTW4GD/oqWxLUFXEMU/LgbqVQo=
=PbpF
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--


--===============2519851863857611000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2519851863857611000==--

