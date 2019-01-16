Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5065DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:27:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D46D20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JP9IwHyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D46D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UuxmAPs3hobex8NKbjFoHv93A5g9Cu/fP5vpM1Gd+o4=; b=JP9IwHyoM4qpZ6
	vsHqAcou6yX86Y4486ZYHt9i3bFZopybLAon4W7XOznXLdFvYHvebd3q6TAs14CJHxIetefjBENmJ
	GHzPiEMJH+h0C0M58MXL6lntXInuP3iFQunuchMbrSUTUA8lVVjkOc773ybr0OHQY2fmEfv8t3Cr0
	pFrNcqcxsNN1QnYbvKFi8om9bd8uiiLRm8Ox2Jbsk0+rlMaCW5YnYtRjbsMIrezQNar0KdgPvP4Dm
	DcFW7gT93i9bnZ+GVlpJSFjhb7B6d/jD+1qPzcOzKvGwidWvCG+MlkjXWVXriKfAqtvlhfL5sInPF
	qHJHd/zDmPnQY05kOJAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlE9-0002p8-DE; Wed, 16 Jan 2019 13:27:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlE6-0002oi-By; Wed, 16 Jan 2019 13:27:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CB580D;
 Wed, 16 Jan 2019 05:27:25 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 99B543F70D; Wed, 16 Jan 2019 05:27:13 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <20190116124431.GK24149@dhcp22.suse.cz>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d074a7aa-9582-b95a-dce0-d95ac3d3c949@arm.com>
Date: Wed, 16 Jan 2019 18:57:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116124431.GK24149@dhcp22.suse.cz>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_052726_409733_BB99A14F 
X-CRM114-Status: GOOD (  15.98  )
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
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz,
 rientjes@google.com, palmer@sifive.com, greentime@andestech.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/16/2019 06:14 PM, Michal Hocko wrote:
> On Wed 16-01-19 04:30:18, Matthew Wilcox wrote:
>> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
>>> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
>>>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>>>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>>>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>>>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>>>> architecture. This creates a new generic GFP flag flag which can be used
>>>> for any page table page allocation. Does not cause any functional change.
>>>>
>>>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>>>> generic page tabe header just to prevent it's potential misuse as a general
>>>> allocation flag if included in include/linux/gfp.h.
>>>
>>> I haven't reviewed the patch yet but I am wondering whether this is
>>> really worth it without going all the way down to unify the common code
>>> and remove much more code duplication. Or is this not possible for some
>>> reason?
>>
>> Exactly what I suggested doing in response to v1.
>>
>> Also, the approach taken here is crazy.  x86 has a feature that no other
>> architecture has bothered to implement yet -- accounting page tables
>> to the process.  Yet instead of spreading that goodness to all other
>> architectures, Anshuman has gone to more effort to avoid doing that.
> 
> Yes, I believe the only reason this is x86 only is that each arch would
> have to be tweaked separately. So a cleanup in _that_ regard would be
> helpful. There is no real reason to have ptes accounted only for x86.
> There might be some exceptions but well, our asm-generic allows to opt
> in for generic implementation or override it with a special one. The
> later should be an exception rather than the rule.

Fair enough. So we seem to have agreement over __GFP_ACCOUNT for user page
tables but not for the kernel. But should we accommodate __GFP_RETRY_MAYFAIL
or drop them altogether (including multi order allocation requests) ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
