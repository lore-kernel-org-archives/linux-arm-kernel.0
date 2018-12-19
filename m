Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D54221850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nA3X/R/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D54221850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6bEdIBMV7IftL7hE2zAcfchL5Elejb4eCOG0xWfruo=; b=nA3X/R/Y8eQ1P1
	wnP+YQfb4eKamcGz2bBSpZfWJIzEKq8FcaS/yFYDWjtPPE5MyZg7uxKoMVcfKHdFiN2HBWlVlaQo5
	O6e//4anbGjOLkrtEqpSej21bxARE+cFKH34e5Z7Mx1f4gknsxGv2v9L5gxCcMqSwkzMthWGzLWuP
	fQR+dVBneQVNS57fN6tIQzhCVzF1O1XlTZe2k3ptJQRDTjRjH0I5kUt514t5TocD1CmtKQl0W+ipE
	DokuNxhd37t0TFnEbH4K8Yzggp8B1BDAFsfhh98gWgvoH3SqF2PXBGfcX6lO0/ILdhp3w4OrHqkdG
	JstKrGOjmatgtmdqGnbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZVYk-0000gs-FM; Wed, 19 Dec 2018 06:42:22 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZVYg-0000fE-UR
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 06:42:20 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 9559C67358; Wed, 19 Dec 2018 07:42:06 +0100 (CET)
Date: Wed, 19 Dec 2018 07:42:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [15/15] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181219064206.GA27018@lst.de>
References: <20181207190720.18517-16-hch@lst.de>
 <2e779fa7-dc9f-7ed8-252a-5d20c5deca9c@collabora.com>
 <92096de9-7183-dbe8-2169-0143190591fa@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92096de9-7183-dbe8-2169-0143190591fa@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_224219_130163_03C39280 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 linux-ia64@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 ezequiel Garcia <ezequiel@collabora.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Tariq Toukan <tariqt@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 08:42:46PM +0000, Robin Murphy wrote:
>> [   16.046084] rk_iommu ff8f3f00.iommu: DMA map error for DT
>
> Yup, with this patch as-is, anything which isn't behind an IOMMU will be 
> erroneously banned from DMA entirely - see here:
>
> https://lore.kernel.org/lkml/20181214142435.GA18448@lst.de/

FYI, I'm still waiting for a review on that..

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
