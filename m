Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFCC61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:01:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEAC20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YYPdfi7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEAC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W1NAk4d7vDPOm3mfiHUHxrJfwtFZ4u/Z+KVLHlFC2Ws=; b=YYPdfi7fGkADh6
	Z1wikijGE9xCURbC/3Syv8dUyu9dMptUwM4qeANnmu/yaci1xll26GWLl8QR/kFWoqBqGp+0PaMpK
	x1BV8SI5gsbhPW3KhiUOLm107OJItp4ZQPD04+gAWs2yeRziIDxtyoO0IZch5BGgyYVjnuwsM8pf2
	b+sGBMNEkF/creg3GtjNfBO7Vyp6BbO+at6vvycPrwWFCD5r2HYz8TXdYVOGuyyGzLcgwztu4+GSx
	pNITnfndOks+pJ+p5cHdb6xwJ6qz6YpFEJixIdbFh39qd4IrePAlienouV4v2HW5xsNROeB+MjMQV
	rizPqq8LVgwPY/yH0uSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl0YL-0007xY-04; Sun, 20 Jan 2019 00:01:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl0YH-0007xC-5V
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 00:01:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BF36A78;
 Sat, 19 Jan 2019 16:01:24 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6972C3F6A8;
 Sat, 19 Jan 2019 16:01:22 -0800 (PST)
Date: Sun, 20 Jan 2019 00:01:18 +0000
From: Will Deacon <will.deacon@arm.com>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
Message-ID: <20190120000117.GH26876@brain-police>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117092718.1396-3-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_160125_215095_671B2A11 
X-CRM114-Status: UNSURE (   9.69  )
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
Cc: linux-arm-msm@vger.kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> Adding a device tree option for arm smmu to enable non-cacheable
> memory for page tables.
> We already enable a smmu feature for coherent walk based on
> whether the smmu device is dma-coherent or not. Have an option
> to enable non-cacheable page table memory to force set it for
> particular smmu devices.

Hmm, I must be missing something here. What is the difference between this
new property, and simply omitting dma-coherent on the SMMU?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
