Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C102086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="trB/Hm3L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cs6vHpZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C102086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A8z3sEV0ouL9IcWr/Sz2nTr/mgXAI3iufMVdnqXWQ1w=; b=trB/Hm3Lem5mVRxH5/Fztdrhg
	Z/rJbMyWmBuRro6wbt8Cac6ysnwMWjK/Lzmzj8h+cRSQK8UCRQgAcR0tDPSplW4BifadIoM6hlXTL
	EeEitja7s1Xt2EQ/my45yWbW9yRV7QJ2J5uQDOG9tlxKqRiqenVf5VlfdsNczFIS9ALZJLu31mapx
	d/fpw/U/Ymzpv13IYpq6EeP0MuNivaCfQhmnRBPImyexXK54mnNHMS193QMenXo+XILCgewU77N4D
	+r0JaYaJFG30Ps/6/BLRzrL6tlCtf7cAbCV9EBV9/3shY1OIwn6fKpeJmHnYVPfcJG9WbPSgy8R/p
	iRNexOk/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4nX-0004sA-Jl; Mon, 14 Jan 2019 16:09:11 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4nU-0004rf-BM
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:09:10 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c3cb4130000>; Mon, 14 Jan 2019 08:08:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 14 Jan 2019 08:09:06 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 14 Jan 2019 08:09:06 -0800
Received: from localhost (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 14 Jan
 2019 16:09:05 +0000
Date: Mon, 14 Jan 2019 17:09:03 +0100
From: Thierry Reding <treding@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Message-ID: <20190114160902.GB9218@ulmo>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20190114132240.12125-1-m.szyprowski@samsung.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1547482131; bh=Hho0bexQ0Le6MfmPACNhTD5m6Tyma+N1LaqmRui0WM0=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:
 Content-Disposition;
 b=cs6vHpZiji7SXIcN2FueDybgSToz6R4hpwkbq6GSdkDhQzBeGK9qH8ROvIgEzf787
 X8J9FWUB6tctQOEc53b7T4nS7w/9pizSXMRhCaBn7jUsCbTCR9RmGzFssbYW1L3fZi
 5rTTMcX8yqHw7K5jxhXDlU2KpFKxrVzlcMRnGGenrntWm7dqS9mU8ZLWK5y8n1hlAE
 3yqxy4sE0BdQ5C7gEOQDjwlgyVCDgjmHtq9HInM7QMRO2RB/adKHzK2GyBunMtWLz/
 8g8xZDg5TJI+kzAIFQqnEpcJVvPj2jmPV3NqRONIjTq46dnsu4n0prFhIyF57gmSiB
 U4Ntgy5f2GzNA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_080908_404571_48E4AAD1 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6279808918998879058=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============6279808918998879058==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>=20
> That patch broke IOMMU support for devices, which fails to probe for the
> first time and use deferred probe approach. When non-NULL dma_ops is set
> in arm_iommu_detach_device(), the given device later ignored by
> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>=20
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_de=
tach_device()"
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mm/dma-mapping.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Can you point out exactly what drivers break because of this change? We
need to find a solution that works for everyone. Reverting is only
marginally useful because somebody will just end up wanting to revert
the revert because a different driver is now broken.

Thierry

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw8tBsACgkQ3SOs138+
s6GvdA//W9RbyrwK0Z1YF6WLWPz/Vrii+8f8EHn/G8ZOdAmYNIJLbATdEhoF+3zo
Fr6+hdn1ZOtXfyMMTXz63/c47xpiJVqpCj09vIt5qv7Mixu4xA90obTA227xDvVE
7ta1T3DXzMskYiUgqSQUceJh2MIHLjpF4yFtoAvsn4y9Uji7CkcVbaoCmRVy3fGJ
rNGPBRSbbIR29Ox3fpECd+zf+9Ca4YhwD08+IuZ04vBO2JOnAh/gzephofRsYf/o
uqkxLdRux2c5tvzJIkuovYrbSYKNCuB/2GMy+mDVdUVpKpuOeI+XnryipeaGLX1W
wD+hXq7uJ63s6HEH7IkIb6s7TjZEhHmtYSA8vw5KWbGPj47t1Yr3P+aD4dZ5hOaU
w9EhRJW3WKUgWH5jioTtXU9npYXwDfJG3+TKe+XNB2fQ6gOhttoch+lMggtgNEzK
a85jKxcnXV7Xpo7UHz7KJGivug20QvAsYSipVjhn6CXBdIg6PEfOgOmAULhpX/O7
gQxUdeVhvW4N8WS4nkVMJ8Kudo8370WQ7gHW7kYSLE7ncksa17cbMegb3jq5dvax
9HygtnaTqdO8VlbdXghXU8C7X3z1eWeUJO2ZcedmsVPSRzJ4lfYxfK4ep/YsqS2q
fgCBQmOzZV6JNPJNUZzeVedrIArWbr6DejaXff4LjfO/Y94Q7rA=
=cziU
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--


--===============6279808918998879058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6279808918998879058==--

