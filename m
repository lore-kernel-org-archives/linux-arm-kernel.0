Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284A5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD0B2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAAokq91";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EidZGXQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD0B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VNxgTA5Owi0KTu5wm+rMTBd8JTOH4goEO1Yvq6QCZR8=; b=LAAokq914k98ClOC+IuGc1RoI
	kDGjI8VgwCL+VZeLT7/lBfxVx7Ctne7Y2qdRToL53ljhL/addzIG15Wx4/q9actHR0gZLGTtpCBUg
	l66vBiVnk/Cfj4dK7k0+fuLSbwuL2VbYKrwH+KATCa//DJuaUFeC68oQ3NIpVylxICkXT+sYDYu5u
	9NkL4Q4jR3ztO5Xu4mpslbk1Hfodt8qgfZMHXgkfG9w3t1YvH2pRLt7gbm3fwqiAZnnHQ/xx0Z7zW
	X3G2VtDMAT8/fBdW8i7A+uc9xVVQcsVJigPE1dRbeDybjdJlf+5zkaJ2malM6oIvg5k4bCraU1C6y
	3J9BaMNtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWPc-0007Sq-CE; Wed, 05 Dec 2018 12:36:20 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWPU-0007RM-Cd
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:36:18 +0000
Received: by mail-ed1-x543.google.com with SMTP id d3so16864586edx.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vrtMh2jYTpv83rVG5A1QYng8vN5RmiJeEXK7511FJH4=;
 b=EidZGXQClmZJRKgORRKQ2z2JfBQuXzu4/XxBc3E+vzeqS19JbW0mm56hkaACtKJIeo
 /rCoHX0L5LiZfXDY2WX5cJRZxa8msNVo9aWJf5Hh1Hyky7YjwcOmKLMM6qLEcKiRPBzT
 MBUMVseU81Xk3QztKaGGeILfZUG2oV68ZKhDMyJcAFupi2z4wtiecu0Pd2B7csQFLxNW
 XY48Pv5Otaw7YS+7LoZmbF9ImSHrrpXzTF0H/m/PjtffMtI3rR++F7/Tu3yI3cLAOvde
 o4GKE08/YqkGNMlioJP/XHjq7CpCuyBNYCW1cpnH/ft6Xl8/GJ8SN76DMZjrG8gpUiGi
 Yk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vrtMh2jYTpv83rVG5A1QYng8vN5RmiJeEXK7511FJH4=;
 b=iQiOxjTfRd3pLoWnYsjoEwKSDXp45fDlOcViI9hVpziA1QOAFXt+KJ9Gg4xehntwEz
 9Cjv4pEDujTRg2lRfPfjnIw5WHz2bjQ4jUmedyuxP6E2Y9I2FiJyFHlsxF8O5QZK1eLV
 sOkmFn83OZj9diF0iS8zRDb1Yqe9T0hT91J/Oqw02ShYZOKfEfaTCdq27bP0xesdfiG5
 NdV7L9HyIg7bceYRx3CUlAW8/lrqlERrCvps4qiew5/AF7ncBQBCKIcLi7zuzyOz6Fal
 7MeVe4gKTcSi07++Oby8lwf+ealT/stsSeoEN2FQsPFufzyCHcbOTiIia+JWTKwhH/Ll
 bgzQ==
X-Gm-Message-State: AA+aEWZIO+/BYYR5Q1fmmecIyjwERp2Blk+MTk2wlvrheZv2iMnzd/ii
 xXRl+/HpTsu7h+bbBk81OrE=
X-Google-Smtp-Source: AFSGD/UbaJgplGgnh0sSK8r8lCqy6Xr6JmtwNzdUixkP06w1u2ecj++UaxQlSQ2R+bE+lD/K0rqrrw==
X-Received: by 2002:a50:9e43:: with SMTP id z61mr21449735ede.90.1544013359613; 
 Wed, 05 Dec 2018 04:35:59 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id c12sm5220873edi.52.2018.12.05.04.35.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 04:35:58 -0800 (PST)
Date: Wed, 5 Dec 2018 13:35:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-mapping: fix lack of DMA address assignment in
 generic remap allocator
Message-ID: <20181205123557.GA28929@ulmo>
References: <20181204142304.GC2618@lst.de>
 <CGME20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9@eucas1p2.samsung.com>
 <20181205101401.3561-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20181205101401.3561-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_043612_453489_A8BA1C6F 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Ren <ren_guo@c-sky.com>,
 Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4609738880487062776=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4609738880487062776==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 11:14:01AM +0100, Marek Szyprowski wrote:
> Commit bfd56cd60521 ("dma-mapping: support highmem in the generic remap
> allocator") replaced dma_direct_alloc_pages() with __dma_direct_alloc_pag=
es(),
> which doesn't set dma_handle and zero allocated memory. Fix it by doing t=
his
> directly in the caller function.
>=20
> Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap a=
llocator")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/remap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Thierry Reding <treding@nvidia.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwHxioACgkQ3SOs138+
s6FrEQ/+JDxH1WopBJG6bpMeKByiWYJdObpk1wWcMYzSme2BnvWsUJW1OM7ctUOT
AZKVxbWFbaDJdLs9xlkIkVAOMe9i9eGkwFJB0IugR7NlhH3HV1VPbd99K4VvmV1q
hAtBq8UEod1YXBD7X836sJLRsYwzEb6TP6E2en5EPMDgrOS5N1rhcCyslorrXoqs
h+n3wZllTQxBr3liY3FFwawKDYuSj8PRqsn8AKXh5KXJS6F718lpPxL4PmnhWPUB
76YA6uqe5mYPvdxAS7lEhM+BjuNBRSO7rGSOJpBVkcXbDxb3BJCGMnhUbmnjRDCH
0zyIyaKQa926YoZIhSOcWCIgQdPpXUWf67BOaX7phmL0fIUwfjJKsMQY80Wcqxxu
YzqE36DCHj46h29PbhXbBcy+/bCBZ7YgDCQsHBk6+gYGJbYLj77ouN2L8OrmcDBt
+yXpoyQoRDiGhDQ4UBEvK4bAKvBPG77G5Z/he3XvKIwty/ErnKC7aVWpa+a2sn+x
mnOz+E7M6eVM/nSkdXRn/wWfAxXYZbwJ5+oLMyKERHEyvl6/acKAoTmH7vNNVmjt
TKdXUoEQr1rTzGD05Zlm0wC5sB8+PnCIJQV/g779HpYLNtFJq/YyAF2d2NoVXkcg
EDMdZsy7f/vWd0+4oKpR18RvDdKzBuzHUJdiVC/P9rt7FDvI5YQ=
=TbI5
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


--===============4609738880487062776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4609738880487062776==--

