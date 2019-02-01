Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DFC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E62218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ub+bX4XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E62218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JT8POanF2t3JBiXkmGZWRq/d/ew7OBx0IwPnmels+8Y=; b=Ub+bX4XGV1+ozp
	5yC5xypCt+3CBmH9/BkOkegBKBTHIa459E3DdcRDDpXBsKWVctz8NXCrLMOd4Xl5p/fcfnkiMDHHR
	9/VtPGYsPe1ufzgfBWoyArHTgPPas2sf70X99kRRaXGPORC5H1iy0iPotMDzH6upmtzm7ZVx6lUQ9
	nPP67y1ijsDFnn6gDWM86cdCIOf0aXhXU07HhLu0kRrNvmJVawYUqHmeGZqbszQnfnyA/VcXArC2u
	dzKPxJMlnw+9xqCgDNnGxOGHCjim9qLjtqDbygZ/GyQLoqabYWMrf+AeraV4qP/0K3Eu/SfrV8Ayg
	9YUqks4Vm9NTGYt3mMKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbRG-0005Ed-L9; Fri, 01 Feb 2019 16:13:10 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbRD-0005EK-HE
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:13:08 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 2209068D93; Fri,  1 Feb 2019 17:13:06 +0100 (CET)
Date: Fri, 1 Feb 2019 17:13:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Message-ID: <20190201161305.GI6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
 <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_081307_716498_706CC455 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 02:47:17PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
>> includes unconditionally so users can rely on it, and add a missing
>> comment describing the #else cpp statement.  Last but not least include
>> <linux/errno.h> instead of the asm version, which is frowned upon.
>
> I think the __KERNEL__ and asm/errno.h slip-ups are things I cargo-culted 
> from the arch code as a fresh-faced noob yet to learn the finer details, so 
> ack for those parts. The forward-declarations, though, were a deliberate 
> effort to minimise header dependencies and compilation bloat for includers 
> who absolutely wouldn't care, and specifically to try to avoid setting 
> transitive include expectations since they always seem to end up breaking 
> someone's config somewhere down the line. Admittedly this little backwater 
> is hardly comparable to the likes of the sched.h business, but I'm still 
> somewhat on the fence about that change :/

As far as I can tell almost all users of linux/dma-iommu.h require
CONFIG_DMA_IOMMU to be enabled anyway..

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
