Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C1AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167C220656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aSq21gNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BymwqkZZKTbjPNpFeCtxW7r0oaC7s/EnvaQYSd1bpEA=; b=aSq21gNR3NowKQ
	k88NmVLnvipL244NfiA5xZ06qUhqKjZzFwqDGvq4i1ROlzbJcCOSGVsomAsXVl4wG7kPPylV2QMZH
	xHOBDzfvsr7IpM3R+zV1zOzqzQFb+DkC5oEtNPa71ept78dOjYANpEH8i1oQPKCDZXpaFfDR/XGkP
	p1TZ844PRCxFOvnOck6eILVz/usRAMVeSoWOWiyND/P1ezIfLK94O4SOZXPOuP25citGzxHO/C88N
	7xn7MvrXty3x1tKXNv0d5fIsMP789YDpLelrMIm49KOCv8/tIAWu/jsPTRlBs7VQliIVeQ8uRhXus
	+R+IN5FKoC2jfv7SR6dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizX2-0006ri-IA; Mon, 14 Jan 2019 10:31:48 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizWy-0006qu-1S
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:31:45 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 8F14867358; Mon, 14 Jan 2019 11:31:39 +0100 (CET)
Date: Mon, 14 Jan 2019 11:31:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Message-ID: <20190114103139.GA31005@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-4-hch@lst.de> <20190111175416.7d291e25@coco.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111175416.7d291e25@coco.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_023144_223031_5AA261FA 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 05:54:16PM -0200, Mauro Carvalho Chehab wrote:
> Em Fri, 11 Jan 2019 19:17:31 +0100
> Christoph Hellwig <hch@lst.de> escreveu:
> 
> > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > resemblance of a dma address for a a physical address that does is
> > not backed by a page struct.  Not only is this not portable to other
> > architectures with dma direct mapping offsets, but also not to uses
> > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > dma_unmap_resource interface instead.
> 
> Makes sense to me. I'm assuming that you'll be pushing it together
> with other mm patches, so:

Not really mm, but rather DMA mapping, but yes, I'd love to take it
all together.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
