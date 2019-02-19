Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C03D2064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SOVIsElR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C03D2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RD1GYNNzsJD7tXANhy+TzT5/YFShO7sZyDTrgC3nojs=; b=SOVIsElR/tZWyD
	LF+gD5rF+d/qDo6zj5g0SDbNyyFlcfnlAJi/9xFeOOAqEY3s7SHdgs0OLvWtpTcT2/w/v8dup1iuO
	bwP0Wd7K/ALn4dQu2LbVvuemm0V63AajReA5H9QyEUVBGQ657H9kqPfcqaoT+F9SRPpK8iiG945Nc
	VN1m0t5rsFDDs7pNJjVmxdvJZuRVfZg/qcaaZ5JqEJgd7s5AZ4brGmT5i3qSfrOSa5kioEAZaAqHT
	0n97/MZjJOcZnGG0XtjoSMebcxhhIIAVYCdHvfnpL0J8sG/U/r0aNcb3XlJ4UmTB+I65JMUp0YxNm
	bdpqZIkNpI9NWJFFcS0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvvmI-0001PX-3Q; Tue, 19 Feb 2019 03:09:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvvmD-0001OX-LV
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 03:08:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB1480D;
 Mon, 18 Feb 2019 19:08:54 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0EB4C3F575; Mon, 18 Feb 2019 19:08:50 -0800 (PST)
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f67b5468-2144-c51f-6cf0-ea7ece93b502@arm.com>
Date: Tue, 19 Feb 2019 08:38:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_190857_708328_5710C011 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 linux-mm@kvack.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/15/2019 02:46 AM, Yu Zhao wrote:
> Switch from per mm_struct to per pmd page table lock by enabling
> ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> large system.
> 
> I'm not sure if there is contention on mm->page_table_lock. Given
> the option comes at no cost (apart from initializing more spin
> locks), why not enable it now.
> 

This has similar changes to what I had posted part of the general page table
page accounting clean up series on arm64 last month.

https://www.spinics.net/lists/arm-kernel/msg701954.html
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
