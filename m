Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:34:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88889218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZABo1fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88889218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ryx/nI7HgZ+4lCt7Tkv4zL3JDekSvzeSSKlpH0n+mo=; b=WZABo1fuFEk2Pm
	ijk7ntf6iTEAMsrCTU6U5ws+YtrsCtMDRxuPyzwedMB1SAMlPgKP1WX9mzWYINu6kEwz/0NZ3QMn4
	UuTbU0MZ4Aa1qEy+SfkYS59NncQ9UFnjmsuIubYrQ2fauovQWYw2EHrlgkz6dTajhkLRrV2KMy8FV
	3+MwAq2nC9pM6HSm/O9hzvJ2ZPk5qUviFJiqqz6x1ushs8fCPYBdh7332uF3aFfU+AS4W2wO8AiTf
	P8lsdb9D2/i1h+jybConzFy9u5QGy8CGuW6b+tXM/yhEDQVj/eeX+MboKDkRuk83vQtQaq4Boy3gb
	969OvseavPzXCOd3aE1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhNZ-0003Qz-Kq; Fri, 15 Feb 2019 17:34:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhNR-0003Od-DO; Fri, 15 Feb 2019 17:34:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F207EBD;
 Fri, 15 Feb 2019 09:34:17 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8157A3F589;
 Fri, 15 Feb 2019 09:34:14 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 Bhupesh Sharma <bhsharma@redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
From: James Morse <james.morse@arm.com>
Message-ID: <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
Date: Fri, 15 Feb 2019 17:34:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_093417_458873_80B0739A 
X-CRM114-Status: GOOD (  25.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <Steve.Capper@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "anderson@redhat.com" <anderson@redhat.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

(CC: +Steve, +Kristina) "What's the best way of letting user-space know the MMU
config when 52-bit VA and pointer-auth may be in use?"

On 13/02/2019 19:52, Kazuhito Hagio wrote:
> On 2/13/2019 1:22 PM, James Morse wrote:
>> On 13/02/2019 11:15, Dave Young wrote:
>>> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
>>>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
>>>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
>>>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
>>>>> mentioned that the changes look necessary.
>>>>>
>>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
>>>>
>>>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
>>>>>>> calculated as is done by the underlying kernel
>>
>> Aha! Nothing to do with which-bits-are-pfn in the tables...
>>
>> You need to know if the top level PGD is 512bytes or bigger. As we use a
>> kmem-cache the adjacent data could be some else's page tables.
>>
>> Is this really a problem though? You can't pull the user-space pgd pointers out
>> of no-where, you must have walked some task_struct and struct_mm's to find them.
>> In which case you would have the VMAs on hand to tell you if its in the mapped
>> user range.
>>
>> It would be good to avoid putting something arch-specific in here if we can at
>> all help it.

>>>>>>> (see
>>>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
>>>>>>>
>>>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>>>>
>>>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
>>>> It is used for pgd_index() also in makedumpfile to walk page tables.
>>>>
>>>> /* to find an entry in a page-table-directory */
>>>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>>>
>>> Since Dave mentioned crash tool does not need it, but crash should also
>>> travel the pg tables.
> 
> The crash utility is always invoked with vmlinux, so it can read the
> vabits_user variable directly from vmcore, but makedumpfile can not.

(This sounds fragile. That symbol's name may change, it may disappear
completely! ... but I guess crash changes with every kernel release anyway)


>>> If this is really necessary it would be good to describe what will
>>> happen without the patch, eg. some user visible error from an actual test etc.
>>
>> Yes please, it would really help if there was a specific example we could discuss.
> 
> With 52-bit user space and 48-bit kernel space configuration,
> makedumpfile will not be able to convert a virtual kernel address
> to a physical address, and fail to capture a dumpfile, because the
> pgd_index() will return a wrong index.

Got it, thanks!
(all this user stuff had me thinking it was user-space you were trying to walk).

Yes, this is because of commit e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow
52-bit PTRS_PER_PGD"). The kernel has offset the ttbr1 value, if you try and
walk it without knowing the offset you get junk.

Ideally we tell you the offset with some 'ttbr1_offset=' in vmcoreinfo, but if
the offsetting code disappears, the kernel would still have to provide
'ttbr1_offset=0' for user-space to keep working.

I'd like to find something future-proof that always has an unambiguous meaning,
and isn't a problem if the kernel variable/symbol/kconfig names change.

With pointer-auth in use too you can't guess which bits are address and which
bits are data.

Taking arch-specific to its extreme, we could expose TCR_EL1, but this is a
problem if we ever switch that per task (some new bits may turn up with a new
feature). Some of those bits vary per cpu too, so we'd have to mask them out in
case user-space tries to conclude something from them.


My current best suggestion is to export:
from core code:
* USER_MMAP_END, the maximum value a user-space can try and mmap().
This would normally be TASK_SIZE, but x86 and powerpc also have support for
larger VA space, and its plumbed into mm slightly differently. We should have
one arch-independent property that covers all these. On arm64 this would be the
runtime va bits for user-space's TTBR. (This assumes the value isn't per-task)

arch specific:
* ARM64_TCR.T1SZ, the va bits mapped by the kernel's TTBR. (We can assume we'll
never flip user/kernel space). This has to be arch specific, it will always have
a value and its meaning comes from the ARM-ARM (so linux can't change it in the
future). It should be the same on every CPU.
* ARM64_TTBR1.BADDR, the pa of the kernel page tables, which implicitly has the
offset. Again this always has a value, and its meaning comes from the ARM-ARM.
If we ever get clever with different page-tables/TCR values on different CPUs,
these two should come from the same CPU.


I think this gives you what you need if user/kernel may both be using
pointer-auth and both may be using 52-bit va. I'm pretty sure the 48:52 bits can
be picked at boot time depending on the kernel kconfig and the hardware support.

Does anyone have a better idea? (or a corner where this won't work?)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
