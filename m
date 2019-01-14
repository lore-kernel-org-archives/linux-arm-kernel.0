Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E92C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:01:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0134E2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jIHrlcsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0134E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IcMILS1hZd4sobsRduiRYF6HDHOx6urpSfZWrbkR3xY=; b=jIHrlcsVv440xA
	0rrly5qNkvBPCw0lYENAU2r7rCC99P7XiLJ2by64s8D9ijFA2tJfE0VE8NqMxtmXWsNEg76LUoMz4
	j+WydI4TpcsG911sCg/EHWGDzjf8/5xbqChgfzAkqYy6DXaTBmB+vPQhpKEvFF8SRkrHRRZJaRM/g
	RnCkFqWyyPRfOcG8ZDYD9HAwu/SkoyeSuSG+blamXTj/kX8mImMD8rhCQfcO/a7SjhQhwKjn5SObi
	vOrxZQbbM/PB9fGMIZ+QvIW2NTEDNd2c+fZhRv5Nu+stjG8gGHFdTzM01R0veQ/mJxslfQs4/XX85
	Tmc30ZzYFGcNtYr3pOAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gitR0-0004u6-Uj; Mon, 14 Jan 2019 04:01:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gitQx-0004t8-7u
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 04:01:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7078780D;
 Sun, 13 Jan 2019 20:01:04 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2C24C3F5BD; Sun, 13 Jan 2019 20:00:54 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Michal Hocko <mhocko@kernel.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190113173555.GC1578@dhcp22.suse.cz>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
Date: Mon, 14 Jan 2019 09:30:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190113173555.GC1578@dhcp22.suse.cz>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_200107_285284_AF8106D4 
X-CRM114-Status: GOOD (  15.57  )
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
Cc: mark.rutland@arm.com, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz,
 rientjes@google.com, marc.zyngier@arm.com, rppt@linux.vnet.ibm.com,
 shakeelb@google.com, kirill@shutemov.name, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
 robin.murphy@arm.com, steve.capper@arm.com, christoffer.dall@arm.com,
 james.morse@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/13/2019 11:05 PM, Michal Hocko wrote:
> On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>> architecture. This creates a new generic GFP flag flag which can be used
>> for any page table page allocation. Does not cause any functional change.
> 
> I agree that some unification is due but GFP_PGTABLE is not something to
> expose in generic gfp.h IMHO. It just risks an abuse. I would be looking

Why would you think that it risks an abuse ? It does not create new semantics
of allocation in the buddy. Its just uses existing GFP_KERNEL allocation which
is then getting zeroed out. The risks (if any) is exactly same as GFP_KERNEL.

> at providing asm-generic implementation and reuse it to remove the code

Does that mean GFP_PGTABLE can be created but not in gfp.h but in some other
memory related header file ?

> duplication. But I haven't tried that to know that it will work out due
> to small/subtle differences between arches.

IIUC from the allocation perspective GFP_ACCOUNT is the only thing which gets
added with GFP_PGTABLE for user page table for memcg accounting purpose. There
does not seem to be any other differences unless I am missing something.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
