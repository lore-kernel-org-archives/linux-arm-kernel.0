Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E872AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:40:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B929520878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvDOsmc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B929520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B2D6vHrU4emNWOkcCFkMJd81ByqjZarxp0SfivQg5d4=; b=QvDOsmc+PC1+8/
	mLndXzYa8Zr2KY3eCwm8rIrnbtDIiZ4MOuan6MJ7Y0bRVnys6Ix8wWIaBUL59HLdYrqbrSO4LdWhA
	px+I1IDUpltToSq6NhPlS0K4sZY7dmDA3gWi2i1FRIugW3XdH1/c418FNWXRzmh0Yw13+AEACH+bi
	2YMbHLb+nO5WXW/oET1trdQts7oREw+drmnY/CD7stni3vWI7yYzZTuBCgawOxk9NB8n6aaMY2/Cz
	43AbSaJplwReSY+HWS9eik1CYYc6Koh69fR3pJZKnL/sF4hebfGbk0lt755u7VaAtvwZ2SdPDIDWo
	KQPhnbehpSBTbBokPxnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUA04-00059e-Cn; Tue, 04 Dec 2018 12:40:28 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUA00-0004zV-1D
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 12:40:26 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id B9F5913F85F;
 Tue,  4 Dec 2018 13:40:03 +0100 (CET)
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To: Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <27c1c420-925c-c8b1-6103-4eeb885d7e63@free.fr>
Date: Tue, 4 Dec 2018 13:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_044024_224845_8053208C 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/12/2018 12:01, Vivek Gautam wrote:

> Qualcomm SoCs have an additional level of cache called as
> System cache, aka. Last level cache (LLC). This cache sits right
> before the DDR, and is tightly coupled with the memory controller.
> The cache is available to all the clients present in the SoC system.
> The clients request their slices from this system cache, make it
> active, and can then start using it.
> For these clients with smmu, to start using the system cache for
> buffers and, related page tables [1], memory attributes need to be
> set accordingly.
> This change updates the MAIR and TCR configurations with correct
> attributes to use this system cache.

This is version 2 of the patch, right?

Version 1 would have been:
https://lkml.org/lkml/2018/6/15/186

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
