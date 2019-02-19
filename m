Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0228AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:44:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42FC2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vh4S+lYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42FC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CjN5AXcA7d5h3XZAEj0KC5wONrdie67z0ZrnIFfFSBo=; b=Vh4S+lYMWxh+S+9Z5X5WG1K8W
	ipF+jrXsDYWxKcsGFEGpHOLJQlJ/Dmn2kicIKKt/vI+9svTOL/k6nHvyzaKh9PufI8NYLbZ/Cl6ej
	ilejQMSWmXByi6P+gKkkwSR2apnJvlwNK9I9aOZZx2z0bYH1bw9f59sD9jrEFlKiZYgPcSSHhsfLv
	eOKGJjfT9Qggyvpy2b/nreHizVDNb/6grTM83xX3Ta8ulajkVGqUsAJ2LSVOltmn6grptu0AnFkNy
	Y2liDWwU6KcF4tbURRTGihOdKSFb0aXh3YvX5oWmZX73r6rtlf8aMgDGljoj26xCrRE9bpNw2NSUX
	Pvd0FlrKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvwKU-0005ZJ-BU; Tue, 19 Feb 2019 03:44:22 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvwKP-0005YL-HX
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 03:44:20 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2019 19:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,385,1544515200"; d="scan'208";a="127491915"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga003.jf.intel.com with ESMTP; 18 Feb 2019 19:44:14 -0800
Received: from [10.254.86.162] (kliang2-mobl1.ccr.corp.intel.com
 [10.254.86.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by linux.intel.com (Postfix) with ESMTPS id 58CD1580238;
 Mon, 18 Feb 2019 19:44:12 -0800 (PST)
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
To: Steven Price <steven.price@arm.com>, Peter Zijlstra <peterz@infradead.org>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218113134.GU32477@hirez.programming.kicks-ass.net>
 <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8a74c111-b099-8d18-5fb0-422909a1367a@linux.intel.com>
Date: Mon, 18 Feb 2019 22:44:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_194417_633014_F1BA8B16 
X-CRM114-Status: GOOD (  23.97  )
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 kirill@shutemov.name, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/18/2019 9:19 AM, Steven Price wrote:
> On 18/02/2019 11:31, Peter Zijlstra wrote:
>> On Fri, Feb 15, 2019 at 05:02:24PM +0000, Steven Price wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>>> we may come across the exotic large mappings that come with large areas
>>> of contiguous memory (such as the kernel's linear map).
>>>
>>> For architectures that don't provide p?d_large() macros, provided a
>>> does nothing default.
>>
>> Kan was going to fix that for all archs I think..
>

Yes, I'm still working on a generic function to retrieve page size.
The generic p?d_large() issue has been fixed. However, I found that the 
pgd_page() is not generic either. I'm still working on it.
I will update you on the other thread when all issues are fixed.



> The latest series I can find from Kan is still x86 specific. I'm happy
> to rebase onto something else if Kan has an implementation already
> (please point me in the right direction). Otherwise Kan is obviously
> free to base on these changes.
>

My implementation is similar as yours. I'm happy to re-base on your changes.

Could you please also add a generic p4d_large()?

Thanks,
Kan

> Steve
> 
>> See:
>>
>>    http://lkml.kernel.org/r/20190204105409.GA17550@hirez.programming.kicks-ass.net
>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>   include/asm-generic/pgtable.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>>> index 05e61e6c843f..7630d663cd51 100644
>>> --- a/include/asm-generic/pgtable.h
>>> +++ b/include/asm-generic/pgtable.h
>>> @@ -1186,4 +1186,14 @@ static inline bool arch_has_pfn_modify_check(void)
>>>   #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>>>   #endif
>>>   
>>> +#ifndef pgd_large
>>> +#define pgd_large(x)	0
>>> +#endif
>>> +#ifndef pud_large
>>> +#define pud_large(x)	0
>>> +#endif
>>> +#ifndef pmd_large
>>> +#define pmd_large(x)	0
>>> +#endif
>>> +
>>>   #endif /* _ASM_GENERIC_PGTABLE_H */
>>> -- 
>>> 2.20.1
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
