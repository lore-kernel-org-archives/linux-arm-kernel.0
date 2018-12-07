Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A054C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:35:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED78E2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O1t2FCpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED78E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SWuj1CqwvjqL6DfxSsMVpSEl7Q6QJ4o/wQzrr0IN6e0=; b=O1t2FCpSbZkTKqHeoIQtjTG1V
	QX+MyxVAfcAQytTzz33Gcr9490TWXARMhBAhaELTQB1hEUKCDkYW1m9A+XuBZ/Zfh5JA0jCsqsnd2
	TTZhAursNaJINzKfLnFmQTBdiw5kk5F27WN2kn+qHLIL+YzshG89ppUm3V3Y5wR+OqkGV1UjGPI2a
	yFyB6saxM3ChfSpv+0Dq8R7PVPfx4r9Rum0f8jCn4gX/hFXoK5fHJq5gbxxkH6x5UjTNBIwVeEiRW
	VHMkiy4GRevWmBmwcP9QucaG9omI2tfwuAQd7E2w0zn/RLTffyxFFijawRHSKjMeNy2CYcZC+xGd7
	eAvaTP+0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVK26-0001tk-Sp; Fri, 07 Dec 2018 17:35:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVK22-0001sQ-QV
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:35:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC1EEBD;
 Fri,  7 Dec 2018 09:35:08 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A67F3F5AF;
 Fri,  7 Dec 2018 09:35:05 -0800 (PST)
Subject: Re: [PATCH 0/2] Refactor dummy DMA ops
To: Christoph Hellwig <hch@lst.de>
References: <cover.1544199754.git.robin.murphy@arm.com>
 <20181207170519.GA26857@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <84be56f9-d195-78c3-df4d-7e0c1f71e4d9@arm.com>
Date: Fri, 7 Dec 2018 17:35:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207170519.GA26857@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_093518_864451_93C32D48 
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
Cc: linux-pci@vger.kernel.org, catalin.marinas@arm.com, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, will.deacon@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, gregkh@linuxfoundation.org,
 bhelgaas@google.com, lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07/12/2018 17:05, Christoph Hellwig wrote:
> So I'd really prefer if we had a separate dummy.c file, like in
> my take on your previous patch here:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/e01adddc1733fa414dc16cd22e8f58be9b64a025
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/596bde76e5944a3f4beb8c2769067ca88dda127a
> 
> Otherwise this looks fine.  If you don't minde I'll take your patches,
> apply the move to a separate file and merge it into the above tree.

Sure - TBH I did consider creating a separate file, but then didn't for 
mysterious reasons that don't stand up to scrutiny. If you're happy to 
do the fixup on top that's fine by me (if culling .map_resource was 
intentional, please scrub the last bit of the commit message to match).

I'll make the equivalent change locally anyway just in case there's any 
other cause to resend.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
