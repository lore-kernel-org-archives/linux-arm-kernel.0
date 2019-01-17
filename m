Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A174C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:01:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B41A20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AfNX4TR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B41A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lqd6gjLCGAULxerww38FjpRCTxLM9dpbmpyqUkKIma8=; b=AfNX4TR+xT54bJ
	PK05Yu9APNlLPsXiTTV9DtjVbYgb0K/NCysSKGKuFXEcXWAHIo89pGUv26xfjIT/CQocy2cDG+IPN
	Vaz4V4OtnCQV3yN4KYSIfSQbkEKuMFmZ4rVEdaCfGx90gST1DqEjtZ52KBWBYK3/8GyOtxkZdBrwL
	DOQNf3WoxIouDCH329WHbPoQnBIeH8dOp4jH8PiygOhjB37a9QzWtDwlmvW2xPJH4nMIcKKQQBwgJ
	z8wRLdMRb1YsobGYM9WqiP9X590j2hcuqWb2j7vi14HH4Dk2nBH8DpLSx3m1K7jFeTCX6AfCSfL/X
	WgThFBRbppng+WrvO7Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8Ew-0000yG-BC; Thu, 17 Jan 2019 14:01:50 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8En-0000wy-4r; Thu, 17 Jan 2019 14:01:47 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gk8Ei-0005CU-PN; Thu, 17 Jan 2019 15:01:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/4] NanoPC-T4 (and a bit of NanoPi M4) support
Date: Thu, 17 Jan 2019 15:01:36 +0100
Message-ID: <21515619.cB86tSjWlH@phil>
In-Reply-To: <cover.1547466003.git.robin.murphy@arm.com>
References: <cover.1547466003.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_060141_331327_EBDA151A 
X-CRM114-Status: GOOD (  10.77  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 14. Januar 2019, 13:05:30 CET schrieb Robin Murphy:
> Hi all,
> 
> With the initial patch now queued (thankfully solving the version-number
> conundrum), here's an updated v2 of my further changes with the tweaks
> Heiko pointed out. Comparing GRF dumps didn't give any insight into the
> SD card thing, so I've kept the GPIO patch; ~100 interrupts per insertion
> is still more useful than 0!
> 
> Robin.
> 
> 
> Robin Murphy (4):
>   arm64: dts: rockchip: Add DT for NanoPi M4
>   arm64: dts: rockchip: Refine nanopi4 differences
>   arm64: dts: rockchip: Add NanoPC-T4 IR receiver
>   arm64: dts: rockchip: 'Fix' nanopi4 uSD card detect

queued all 4 for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
