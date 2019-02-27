Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEF6218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PhQeYiqm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSQJ8vEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEF6218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Xj+3AWpAX6tvgWERQwPNy8O9tyBy6zGX7i17Hz1KLs=; b=PhQeYiqmSZIiTB
	Fg7d5Yc/UWzO/Ri4IsAPTya+WY+iTDXHsB5eZhBW8cHIPZK3YtCVwyA74HXUUZEQWbuEizp0KadAP
	3ZssM7DAe3EMiXDSb9lZCjj5nfvrj9y8V+HsJM4dTG4Ux/3nV1fKZLhySGWWii3s5c4+iql8ukkac
	c5YrfAe8L0qZR6BkvLBvWJOAOwdNqjQZX8UMcaKABILOYJVKuqDR0BdG7n6Ydj9sUlCp2Pvg0H2Dp
	WOQBKJgTH8K1gq7MkT+vyLPsrRdBtZtjxFu+FRrVpndRRJQwzJ7My4+8OLTZoHROKnnQRCnnqar7f
	H/jyLfqZfzOWpvHNTwvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyurB-0000cR-LO; Wed, 27 Feb 2019 08:46:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyur8-0000bv-Ou
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 08:46:24 +0000
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E32DB21901
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551257182;
 bh=+VHybkXZEZgWWpzCP9seJjfryQBRTOnGxtv/T8j9dqQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lSQJ8vEhsxbglFGFB4LpwqAVqzrTfYPvSxXqKaKGlfUmZ33JoK2IYShKiC9Jno9sn
 NZfPC0m9kJ8OpbjJ3kTx3HASoHTeyEy2arS2S0xSzO10mSKl50xLzMS+5ZQHKZcpbt
 FefjVqUg71c3v59yGRq2aGxEUlUckgHn2FZuuCr8=
Received: by mail-lj1-f174.google.com with SMTP id z7so13067887lji.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 00:46:21 -0800 (PST)
X-Gm-Message-State: APjAAAXG+IiWWXmu9jMfCxk63clJtdzAueRVQcQKnoEje+J29L0AZvis
 zgtcmb8Q2X2NIyE1dZuZsCQy87JAlbrkSeShzxU=
X-Google-Smtp-Source: APXvYqzz2cMievIQU2a/inead8cTm0gHAqevhnhk1i1MNAoni62pqp80R+lWnocb+j/Tv4T359hzEaMto8dPxeidjpo=
X-Received: by 2002:a2e:780a:: with SMTP id t10mr639791ljc.19.1551257180027;
 Wed, 27 Feb 2019 00:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 27 Feb 2019 09:46:08 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf_+dME_P9jy5=_LrjYEpgti4+CN0thkSXSvxwSGVH=Bw@mail.gmail.com>
Message-ID: <CAJKOXPf_+dME_P9jy5=_LrjYEpgti4+CN0thkSXSvxwSGVH=Bw@mail.gmail.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
To: Nicolin Chen <nicoleotsuka@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_004622_827791_766D692A 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: tony@atomide.com, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, sre@kernel.org,
 linux-omap@vger.kernel.org, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 at 21:25, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
>
> The original change breaks omap dss:
>     omapdss_dispc 58001000.dispc:
>         dispc_errata_i734_wa_init: dma_alloc_writecombine failed
>
> Let's revert it first and then find a safer solution instead.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
>
> Would you please test and verify? Thanks!
>
>  kernel/dma/contiguous.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)

This fixes broken (since yesterday) linux-next on Exynos boards
(ARMv7), errors like:
dma-pl330: probe of 121a0000.pdma failed with error -12
exynos-ehci 12110000.usb: can't setup: -12
exynos-ehci 12110000.usb: USB bus 1 deregistered
exynos-ehci 12110000.usb: Failed to add USB HCD

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
