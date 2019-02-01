Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC00C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8F021726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LFVMiER6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8F021726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CGHbD6fegJaMaF9KIUTN+tGjJq8k3GDtzpP/LcNF55A=; b=LFVMiER68tA+Q/
	CuJLjTSN+IWS3UO2crqH5GBpqoax1qObsXAlCGMgGY5v2p0tyBJFX/s39vUNyv7604Koygv5BVV7T
	OnfJtymcq0gKgeVfRDH1ruFPA64d3DETe+FfSdEckaDJi26TUoDK8vA7LYDKG55eK0eg1er401mpg
	NdgqqHS4j/JHdu3maxhVQdVaNKBdr/Ou07J+inx4qNFoM0Qxxt6o1sJAg8Wsebsd1U7h1pMhvw2ir
	A4KnVtbI6n/tr4USZd7hRZC6jMyW3JWH/CQvEPKb8RTEja32qHwO/4JoNhn3MVjbh0/HgeleLAJ/E
	zRjOulwVlbZ2vBkGkbtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbQG-0004we-9y; Fri, 01 Feb 2019 16:12:08 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbQC-0004vv-I5
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:12:05 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D614968D93; Fri,  1 Feb 2019 17:12:02 +0100 (CET)
Date: Fri, 1 Feb 2019 17:12:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 01/19] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
Message-ID: <20190201161202.GH6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-2-hch@lst.de>
 <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_081204_743292_37FDA209 
X-CRM114-Status: GOOD (  12.55  )
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

On Fri, Feb 01, 2019 at 02:22:46PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> Add a Kconfig symbol that indicates an architecture provides a
>> arch_dma_prep_coherent implementation, and provide a stub otherwise.
>>
>> This will allow the generic dma-iommu code to it while still allowing
>> to be built for cache coherent architectures.
>
> I've been pondering this for a while now, and I still can't really come up 
> with a case where arch_dma_prep_coherent() would need to behave differently 
> from arch_sync_dma_for_device(..., DMA_BIDIRECTIONAL). I wonder if we could 
> just save ourselves this little bit of complexity by using that instead...

A lot of architectures do really weird stuff in the dma sync routines.
So my plan would be to consolidate a lot more logic in there first,
and then maybe as a next step we could look into using
arch_sync_dma_for_device eventually.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
