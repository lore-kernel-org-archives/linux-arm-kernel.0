Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1620C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:31:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE30D20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UWmkpbxO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pMygEPSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE30D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PEszExL2pLzagzp0MZRA9m10X6cIN70ry1Q93GPka2s=; b=UWmkpbxOU98bn8
	18pLi4rMaWvvoBq6X6YzKfQzhaUXwPg6ZVeq4HPHySZxHCDGXNyigIN0TqCYfXediI29Oy7cnSVW+
	kqN8FD/V8SunhnN8qAk0oOsavM9CXAkHMaRbXk3BmixqA2BFJ0db5R4CQjtFqY/mD2u8AVE+MAD6u
	oG1kuElj2NhOgbkdzSD9qGje67v7NbrbhhQ2TA4coiu0+KpRxXi5O9o0XLKQe4MlOHjc8gYCcSJYf
	9L5iMFmX95xQUZUlySwN0dNSnh2n2mvFcfheukgSA1S+7QDbONPrkh1lpASDUN49YyEOQVnsxy96b
	XA1YhtP5+/YGbOCHadyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydl3-0005eI-OK; Tue, 26 Feb 2019 14:30:57 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydl2-0005dJ-A8
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 14:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1xN/45iBegjZKleQEVGT0GvDc3odHL/T48vop/oVE8M=; b=pMygEPSrkVBeGBo9E4nAx/2kZx
 sssXGrrGhaVgV9uOKtHgCYPOHmzaGrvEFgQ/P00ZZqLQ5f3J6AOGir5Owf4xJq+1+xfUnZ05K621R
 3H2pNNn74zLGoo9uJnBYhsypwNoRMJKNE1mYG2R7nVn2x/frfgOuTqrOzdEEjXC41Nh+50mZFGGIx
 nWS+vZ/WS4ol1+7g5NJZ7+Byge6xNxPE7VGjFp7Ms6owULYgFaNSa/KZorp2IH7OekQAW4jRY6MgZ
 8oMS3IpNua3I6b5uh8H01CR2/CUkWS5b4a06WWAxOhl5DFoRWFvA1rQpxuKbYAqoJMGBbgVwFt5GU
 1hNFJBzg==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydku-0006Ow-4a
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:30:54 +0000
X-Originating-IP: 90.88.147.150
Received: from aptenodytes (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 01317C0027;
 Tue, 26 Feb 2019 14:30:08 +0000 (UTC)
Message-ID: <6db67808e9184e25db0577014317e459b6dd2dfe.camel@bootlin.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Ronbo
 Electronics
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Tue, 26 Feb 2019 15:30:08 +0100
In-Reply-To: <a7ab8bd59ad673f88e2c39cf6cb21bd959cf4db4.1550650810.git-series.maxime.ripard@bootlin.com>
References: <cover.5ac8e6ed5381ceb14a2e5d64671228f665a08d43.1550650810.git-series.maxime.ripard@bootlin.com>
 <a7ab8bd59ad673f88e2c39cf6cb21bd959cf4db4.1550650810.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_093048_305620_5BF4B64A 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, 2019-02-20 at 09:21 +0100, Maxime Ripard wrote:
> From: Konstantin Sudakov <k.sudakov@integrasources.com>
> 
> Ronbo Electronics manufactures display panels.
> 
> Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4f225ce815d8..b64d8316dfae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -337,6 +337,7 @@ riscv	RISC-V Foundation
>  rockchip	Fuzhou Rockchip Electronics Co., Ltd
>  rohm	ROHM Semiconductor Co., Ltd
>  roofull	Shenzhen Roofull Technology Co, Ltd
> +ronbo   Ronbo Electronics
>  samsung	Samsung Semiconductor
>  samtec	Samtec/Softing company
>  sancloud	Sancloud Ltd
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
