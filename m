Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:20:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F342146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8nQQd7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F342146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7/dNKTacw24DX3G6fCrEQbkOLXG5Ol1JaHbnr6Ty2Qs=; b=l8nQQd7o4KL4Qb
	LbPvJX8IAi1IJSb1hUKRJrBVQLxmh7uI3/zjiqNmx+eV8eDrJ1IP/+Li0kAYrL1tb9xg8IYu7ocyc
	u243C1Aq15UNsm1zF5G8tWFQN5YZpq+PXzR6Se2G7mtP/qFIXzIlFEfBTni3ZWlX7oG6lVHYyvXf7
	O43SVP9RfxC2ckQKwhtOT6MJD76R+j0N2iizdgRFx53sQZBsmcGQz9FbGLi7/+hrslInVOVexei9U
	eWAbyMW5gkplF/LQf/7+QUOwCqSREdjhkhZgjilMBoHfpVI2sRBqdzl4gJKMrF39Du/6tBYCBF/kH
	wt3OhCfaHTPsNWo4PNEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwIRE-0003Sw-Q6; Wed, 20 Feb 2019 03:20:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwIRB-0003Ru-Rn
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 03:20:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C88FEBD;
 Tue, 19 Feb 2019 19:20:39 -0800 (PST)
Received: from [10.162.40.115] (p8cg001049571a15.blr.arm.com [10.162.40.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D7B833F720; Tue, 19 Feb 2019 19:20:33 -0800 (PST)
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
To: Matthew Wilcox <willy@infradead.org>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
 <8f9b0bfb-b787-fa3e-7322-73a56a618aa8@arm.com>
 <20190220013407.GD12668@bombadil.infradead.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <383ced45-12be-ce51-187b-bb77cefdee7e@arm.com>
Date: Wed, 20 Feb 2019 08:50:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190220013407.GD12668@bombadil.infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_192045_914117_22655415 
X-CRM114-Status: GOOD (  21.80  )
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
 Yu Zhao <yuzhao@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/20/2019 07:04 AM, Matthew Wilcox wrote:
> On Tue, Feb 19, 2019 at 11:47:12AM +0530, Anshuman Khandual wrote:
>> + Matthew Wilcox
>> On 02/19/2019 11:02 AM, Yu Zhao wrote:
>>> On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 02/19/2019 04:43 AM, Yu Zhao wrote:
>>>>> For pte page, use pgtable_page_ctor(); for pmd page, use
>>>>> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
>>>>> p4d and pgd), don't use any.
>>>> pgtable_page_ctor()/dtor() is not optional for any level page table page
>>>> as it determines the struct page state and zone statistics.
>>>
>>> This is not true. pgtable_page_ctor() is only meant for user pte
>>> page. The name isn't perfect (we named it this way before we had
>>> split pmd page table lock, and never bothered to change it).
>>>
>>> The commit cccd843f54be ("mm: mark pages in use for page tables")
> 
> Where did you get that commit ID from?  In Linus' tree, it's
> 1d40a5ea01d53251c23c7be541d3f4a656cfc537
> 
>>> clearly states so:
>>>   Note that only pages currently accounted as NR_PAGETABLES are
>>>   tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.
>>
>> I think the commit is the following one and it does say so. But what is
>> the rationale of tagging only PTE page as PageTable and updating the zone
>> stat but not doing so for higher level page table pages ? Are not they
>> used as page table pages ? Should not they count towards NR_PAGETABLE ?
>>
>> 1d40a5ea01d53251c ("mm: mark pages in use for page tables")
> 
> I think they should all be accounted towards NR_PAGETABLE and marked
> as being PageTable.  Somebody needs to make the case for that and

Okay so we agree on the applicability part.

> send the patches.  That patch even says that there should be follow-up
> patches to do that.  I've been a little busy and haven't got back to it.
> I thought you said you were going to do it.

This is very much arch specific. pgtabe_page_ctor()/dtor() are not uniformly
called for all page table level allocations (user or kernel) across different
archs. Yes I am planning to make generic page table allocation functions for
all levels which archs can choose to use. But for now I have a series to fix
the situation on arm64.

> 
>> pgtable_page_ctor/dtor() use across arch is not consistent and there is a need
>> for generalization which has been already acknowledged earlier. But for now we
>> can atleast fix this on arm64.
>>
>> https://lore.kernel.org/lkml/1547619692-7946-1-git-send-email-anshuman.khandual@arm.com/
> 
> ... were you not listening when you were told that was completely
> inadequate?

Agreed. The discussion on the thread made it clear that the above patch was
inadequate. What I was trying to point out (probably not very clearly) that
there is a need for larger generalization/consolidation on page table page
allocation front including but might not be limited to allocation flag for
user/kernel page table, standard allocation functions etc. The very idea of
quoting the above URL here was to bring attention to the fact that different
archs are doing these allocations differently already.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
