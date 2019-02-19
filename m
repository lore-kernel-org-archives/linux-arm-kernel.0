Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C2A217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J65OYc1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C2A217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ke3iwn9Uck/EZd9x0IvdU2DN+683IuhTHEkrldEOt5A=; b=J65OYc1GEqMhJz
	8vw1Vq0p5rrKZalbUi37+2pDag5383XNe9Jsq/sgb4umQuc3wZQJ6F1U3geFVH/86pzlND/P+B/Q/
	ExcF+xCCx+N2Mm6u+1lCEe2NY0L9ZRrBmJr4bqyMFPrvJKK4yGkBzh1RGtiIsXeIRJGH3KsWUKEiw
	DAvilWKVgtnUA0CUxevNxwCzRJeD4fnJtpZRJ07F83f/aEQzeh+yAWipG5idedkKf3L5tyI/0xrGO
	htp11cRMJj1a0CseUEisgc+2dvxuZFNgOYxJgEYCWoIQb0bkPpBDVOIo1CAf93ml7RlMHBCsAcS8Q
	FhDylSINK6Ag/xspaMBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvwuG-00016N-AH; Tue, 19 Feb 2019 04:21:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvwuC-00015d-TZ
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 04:21:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93488EBD;
 Mon, 18 Feb 2019 20:21:07 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B102B3F675; Mon, 18 Feb 2019 20:20:57 -0800 (PST)
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
Date: Tue, 19 Feb 2019 09:51:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_202116_959763_B3DDF092 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Nick Piggin <npiggin@gmail.com>, Jun Yao <yaojun8558363@gmail.com>,
 linux-mm@kvack.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/19/2019 04:43 AM, Yu Zhao wrote:
> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> p4d and pgd), don't use any.
pgtable_page_ctor()/dtor() is not optional for any level page table page
as it determines the struct page state and zone statistics. We should not
skip it for any page table page. As stated before pgtable_pmd_page_ctor()
is not a replacement for pgtable_page_ctor().

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
