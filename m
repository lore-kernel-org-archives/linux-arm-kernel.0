Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443CC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A25B2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXOSug84";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZz6gj48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A25B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qBlZZ3kMiTqAX+AFEtiKpncyDbOaS4BFYqIoyFcMTTE=; b=GXOSug84wukf7k
	Ra2/dDnn2JPb9DPlmoOZUlNJn1He/4eahTSJOYJghIow0PDdlZHG4f9ugCMHxfBqaZmj8PuiGAGzr
	H2BW8MyXlBwxlnerlKFIX0HODQeoqSzbeUYYh9PW1zoVI2ZdOfOVb8GEtGJBmINUCGsU3EP1yIog0
	yOE6W8Y1CPq0OsNJ5lm7wAuMrqUi8JX+XHJffnL5pQbhVBrZsEnlc+/O8LhKIdrULDLpgxTdSrErS
	6rhkDXbXi1zCJbaNxhL7cHHYwYRu3NkcQoBFxpzAdtRlHzZfvR2Y76SsgSl1byuc2R/P7S89OekMt
	xYqsqRa3u6T7BXTLY2tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzIQ-0000v3-Iz; Wed, 13 Feb 2019 18:30:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzHg-0007O6-1a; Wed, 13 Feb 2019 18:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FusCe/AEPOdKD2MylUnWVtgOsnXIwLNJrIyv+I+2tU4=; b=dZz6gj48vH4HPSoF0SlPH9Snf
 ucHSZrizxF8CgFCg9FDJSxZOPkzvbIW7aqEsjoQBz2EOq6jLzUvS90k6eiVDHh2TjVinVXQn9XEEg
 DfzHo8GfsvN7NiQI2u1sjUZE5zTIp1DYRVAO0fDVFMPuAyuIby9gCCKMB7WUTFOL0bXri5pA6plIk
 vtyEKv7O1pZJAx2USJoGJ2WzpBrcYxONpq59WBD8Fteu0jdPg6djvB++gLUUTR06xI3lOov0XHqB0
 23Ib8XcQCus89vNT927Vx5RhMbq0kyZ7sQapSGCPP6FLCj/KS9NZmMqBBSTyLMpC3P5g0MEKnTD99
 gzMfGDuyw==;
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz2A-0000oy-Qv; Wed, 13 Feb 2019 18:13:24 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id ABB6468C8E; Wed, 13 Feb 2019 19:13:19 +0100 (CET)
Date: Wed, 13 Feb 2019 19:13:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>
Subject: Re: add config symbols for arch_{setup,teardown}_dma_ops
Message-ID: <20190213181319.GB19606@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_181322_900544_9C67DB0B 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: iommu@lists.linux-foundation.org, linux-snps-arc@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Catalin and Paul.  I've merged this into the dma-mapping
for-next branch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
