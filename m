Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6635EC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39701218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UZTjlMP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39701218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3tr8ifnLxKx4ElKBaFggeeQYFi44P6wMCGksaCUzra4=; b=UZTjlMP1IXxzgG
	84znDtpYOYbGBJlNu2mmG8im47u+9JYsvumsS867D2tVRhpr1lUBH0OdhgTMHemf6IRw1MpdBNDZt
	iQRdTP2pvMlRen+HxtYXP7vgs/uRvHnka7+28ZOi9TMQsKVWmV/f4lyPOPGCmxHxyBA2C4SqpEH8j
	HJ8eg80IhXpa71GnBjE8WKspdagVo3zJJ0oN+JO2WEVftW1YoVhTijaQ1phMqA1V4S+CHrDIALbli
	By2ticMK0bnrRO3ooRoM3GhYJ/+g3xvAGJ8oSU53M1dNz8FF/J8dAn29biMpD9OaKBmntim/gykKf
	swjF2R7sfikhFJ7qzlTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpB8g-0003SA-7Y; Thu, 31 Jan 2019 12:08:14 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpB8d-0003RP-HP; Thu, 31 Jan 2019 12:08:13 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gpB7H-0003tN-Me; Thu, 31 Jan 2019 13:06:47 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Date: Thu, 31 Jan 2019 13:06:49 +0100
Message-ID: <1701923.z6LKAITQJA@phil>
In-Reply-To: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_040811_721326_9794F334 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: mhocko@suse.com, peterz@infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux1394-devel@lists.sourceforge.net, m.szyprowski@samsung.com,
 sfr@canb.auug.org.au, oleksandr_andrushchenko@epam.com, joro@8bytes.org,
 linux@armlinux.org.uk, willy@infradead.org, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org, keescook@chromium.org,
 pawel@osciak.com, riel@surriel.com, iommu@lists.linux-foundation.org,
 rppt@linux.vnet.ibm.com, boris.ostrovsky@oracle.com, mchehab@kernel.org,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, jgross@suse.com, hjc@rock-chips.com,
 xen-devel@lists.xen.org, kyungmin.park@samsung.com, stefanr@s5r6.in-berlin.de,
 akpm@linux-foundation.org, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Donnerstag, 31. Januar 2019, 04:08:12 CET schrieb Souptick Joarder:
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
> 
> As this pattern is common across different drivers, it can
> be generalized by creating new functions and use it across
> the drivers.
> 
> vm_insert_range() is the API which could be used to mapped
> kernel memory/pages in drivers which has considered vm_pgoff
> 
> vm_insert_range_buggy() is the API which could be used to map
> range of kernel memory/pages in drivers which has not considered
> vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> 
> We _could_ then at a later "fix" these drivers which are using
> vm_insert_range_buggy() to behave according to the normal vm_pgoff
> offsetting simply by removing the _buggy suffix on the function
> name and if that causes regressions, it gives us an easy way to revert.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Matthew Wilcox <willy@infradead.org>

hmm, I'm missing a changelog here between v1 and v2.
Nevertheless I managed to test v1 on Rockchip hardware
and display is still working, including talking to Lima via prime.

So if there aren't any big changes for v2, on Rockchip
Tested-by: Heiko Stuebner <heiko@sntech.de>

Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
