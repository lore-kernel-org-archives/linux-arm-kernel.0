Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B799C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D5421850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QqRGGD6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D5421850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D8uVd1FDYjjJpoQz+mE7P1Yr+YJAXoBm/X/Lnt7eIzs=; b=QqRGGD6WT8UOKE
	9Z8ll73lEBduyd24FRZAmXp5QUxgfLhBB71QPu3/p5TJaQea1v7IP1bjRNPjVSs1GPaTYpqNZKR1j
	PgM64y29Y/8Jk7iO6bsVRU9JsS/VhsxxmKdqOuqNS/6xWnYzDiXMl5gv1VB8DK4m/hlwDWkUTDSTT
	d0ClfzYzeDC91UZSAzIhwL6vfaqUgrEr1eEi4yVbOfgOK5nupx+4ymShvxyOkZbLHqrQHq55uS1l6
	qzpgOwUulJkzQuvy3+rIyLOoF8TdYy5bTtepUAmZIsfJbNFV/KB7A4TEmVjR48V+3WYuW67aII7aN
	DZuW/Hr+GrFbJ63dF30Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHBi-00034e-JV; Tue, 18 Dec 2018 15:21:38 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHBf-00033v-PR
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:21:37 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 36697CA235;
 Tue, 18 Dec 2018 16:21:24 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AX_mzEXwXNJg; Tue, 18 Dec 2018 16:21:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id B2B11CA2C4;
 Tue, 18 Dec 2018 16:21:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4bkrzYmQrn7h; Tue, 18 Dec 2018 16:21:21 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 0640BCA2C3;
 Tue, 18 Dec 2018 16:21:20 +0100 (CET)
Message-ID: <1174d7f6742f1c4555f39fbbf2069d7b14193f6c.camel@v3.sk>
Subject: Re: [PATCH 0/3] Finish Armada DRM DT support
From: Lubomir Rintel <lkundrak@v3.sk>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Tue, 18 Dec 2018 16:21:20 +0100
In-Reply-To: <20180710102344.GH17271@n2100.armlinux.org.uk>
References: <20180710102344.GH17271@n2100.armlinux.org.uk>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072135_979893_47B2FA94 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-07-10 at 11:23 +0100, Russell King - ARM Linux wrote:
> Finish Armada DRM support for DT, finally allowing mainline kernels to
> use this driver unimpeded.
> 
>  arch/arm/boot/dts/dove-cubox.dts     | 43 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/armada/Makefile      |  3 +++
>  drivers/gpu/drm/armada/armada_drv.c  | 29 ++++++++++++++++++---
>  drivers/gpu/drm/armada/armada_rmem.c | 49 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 121 insertions(+), 3 deletions(-)

Hi,

thank you for these patches. I've found them while figuring out how to
make the Armada DRM driver work on an OLPC XO-1.75. Seems like they
slipped through the cracks and were never applied.

With a little more work they indeed seem to work well on my laptop.
Feel free to slap in my Tested-by tag (and Reviewed-by, if one from me
is any worth in the DRM land):

Tested-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

The testing essentially consisted of checking that framebuffer
emulation, console and "weston --use-pixman" work.

I'll post the XO-1.75 patches that build on top of this soonish. I'm
fairly new to DRM and they would certainly require significant changes
before they could be integrated though.

Thanks,
Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
