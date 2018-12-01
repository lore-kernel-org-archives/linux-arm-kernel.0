Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997EDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8552082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tna9VBEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8552082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+mXlFCqH/58GW3z4/L4t5r6/7CnDDgtUbw/1zJCdi4=; b=Tna9VBEPaTopx0
	Lpa1DEBDled+LiRhQcm72WRWkziT6wNOS3c9QgqSZ86LmUNskeAPbiHCi04rDAReZ4A9oShK4RF05
	T+FGeY+isfrd4mwzKjmQc3ZqeqzLg8RqGHegJh2Ow1d/vY9u0Mf2r9LtBNgWTyPkrYq7LZjN43aHf
	5s0rYs8ae4iiDo3Vk8+Xmuj/a3SpgzB7T9pQwKAx61rOeRexgc1adqlX0Z0Oc6jC/ktXWVNA9bMHH
	g/hksTv+OJB579bUmOU1xEuX5bjWObVImSS35UxOEgShqnyumTHuGWt5gIiZ+bsFhrziPGJYVw6Rv
	7825eER8uFC/kuACDJeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT8ZA-0003c0-3C; Sat, 01 Dec 2018 16:56:28 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT8Z4-0003NB-Cr
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 16:56:24 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id A5A076732A; Sat,  1 Dec 2018 17:56:10 +0100 (CET)
Date: Sat, 1 Dec 2018 17:56:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
Message-ID: <20181201165610.GA20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-2-hch@lst.de>
 <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_085622_848200_2CA13E04 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
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
 Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 07:04:41PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> Some architectures support remapping highmem into DMA coherent
>> allocations.  To use the common code for them we need variants of
>> dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.
>
> FWIW it's as much about non-cacheable remapping of lowmem as it is about 
> highmem. Regardless, the diff looks OK to me.

Yes, but as long as you remap lowmem the current interface work ok,
but once you have highmem a kernel virtual address doesn't cut it,
and we need a page struct or physical address.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
