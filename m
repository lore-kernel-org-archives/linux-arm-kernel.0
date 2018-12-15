Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D37C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:47:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6161206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P57e2fq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6161206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DFKm2kg5AUB+/wfV/SFar9Ws+7ecizvfIp9rdr/mawE=; b=P57e2fq416pmag
	nXDWtjvAlaZtysg9efhZg6VNs1Rg3S1vIllRt/B7BXJrJFYBPhrYg1vPum32LHyIkDp4sMHy7/5Mz
	NHxSfkVPZcZccxFkoFox3naLYBuJhn3+o8ub0JuYGnqzTPGHebzB6Etxo6Q4AiWN88xRzyyfDmzce
	8EWo5PmXPp4rSj4kin9y47ktqfObO1u7UZDvXiRBysd71nAV+43M7g7gy80AAyW0hz6oq/Qyn21tQ
	XsOBBws+QS6UNbWH59yiub/QWtbvbRuv/KlHByX9ET6Z6XXaSQ/BwllmIvshAWH2qsdgntNhyqS5J
	CAp6UMKNhEKqrFHZXNig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY7U6-0005mG-Tg; Sat, 15 Dec 2018 10:47:50 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY7Tr-0005lT-8k; Sat, 15 Dec 2018 10:47:37 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 18A9268D7F; Sat, 15 Dec 2018 11:47:21 +0100 (CET)
Date: Sat, 15 Dec 2018 11:47:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/6] sparc: remove the sparc32_dma_ops indirection
Message-ID: <20181215104720.GA1575@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-4-hch@lst.de> <20181215063018.GA11415@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181215063018.GA11415@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_024735_456847_1ECB9946 
X-CRM114-Status: UNSURE (   6.55  )
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
Cc: linux-parisc@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:30:18PM -0800, Guenter Roeck wrote:
> and so on, until qemu is terminated. This is seen with all sparc32
> qemu emulations. Reverting the patch fixes the problem.

Hi Guenter,

can you check which of the three new ops is used in this case?  Or
provide the qemu config and rootfs?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
