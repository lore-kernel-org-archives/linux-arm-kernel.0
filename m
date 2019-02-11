Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:35:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F4121B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AxDHZigR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F4121B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y92G7rXC/oGZ31q/O75K5ooXPaxqUubRx7bACwSulB8=; b=AxDHZigR01JMZ1
	TDHUQ61a7DDLB31gRtjuvOLhf/5BBzYLcrRmItlmVBhg32dRakHTsYothfLOfYcGugXPuUkLO3box
	I7NAbLiTlXQ9s+AylE5yJvZVyATWKKiVvL4EfMI0opeSRRbzvsBRwrKvTQpVvms5db/B5DVndXiBF
	qtFczbv5BqMW36EznJBb1mX/oew2SxwZPIkdjDCYmZ3MZxAP0dr/BmJIxzvcxyhatpD9O1Kpaur95
	xO/8jJ4KiFG7onDS69Iyus8zjKhIpydljdtRARziTjQUqcZnveefWr91E9TZGX7h289D9C6blyKm0
	04V14mlTDjPhKPkSJbng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtGQF-0003AR-Ms; Mon, 11 Feb 2019 18:35:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtGQB-0002rC-Cu
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:35:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C0AEBD;
 Mon, 11 Feb 2019 10:35:08 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 788563F557;
 Mon, 11 Feb 2019 10:35:05 -0800 (PST)
Subject: Re: [PATCH v8 00/26] APEI in_nmi() rework and SDEI wire-up
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190129184902.102850-1-james.morse@arm.com>
 <15200237.N8Ro7ITLGE@aspire.rjw.lan>
 <a8b9983d-5eef-2f30-441f-73ce50da7bca@arm.com>
 <CAJZ5v0ibUO7F=+_GBbhEz4nc0jtC=UaK+cOcLCBrXd2pfc0iLg@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f561e55c-3560-6a5a-bd23-5d687227e257@arm.com>
Date: Mon, 11 Feb 2019 18:35:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ibUO7F=+_GBbhEz4nc0jtC=UaK+cOcLCBrXd2pfc0iLg@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_103511_452444_05792BCB 
X-CRM114-Status: GOOD (  24.37  )
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
Cc: Tony Luck <tony.luck@intel.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rafael,

On 11/02/2019 11:05, Rafael J. Wysocki wrote:
> On Fri, Feb 8, 2019 at 3:13 PM James Morse <james.morse@arm.com> wrote:
>> On 08/02/2019 11:40, Rafael J. Wysocki wrote:
>>> On Tuesday, January 29, 2019 7:48:36 PM CET James Morse wrote:
>>>> This series aims to wire-up arm64's fancy new software-NMI notifications
>>>> for firmware-first RAS. These need to use the estatus-queue, which is
>>>> also needed for notifications via emulated-SError. All of these
>>>> things take the 'in_nmi()' path through ghes_copy_tofrom_phys(), and
>>>> so will deadlock if they can interact, which they might.
>>
>>>> Known issues:
>>>>  * ghes_copy_tofrom_phys() already takes a lock in NMI context, this
>>>>    series moves that around, and makes sure we never try to take the
>>>>    same lock from different NMIlike notifications. Since the switch to
>>>>    queued spinlocks it looks like the kernel can only be 4 context's
>>>>    deep in spinlock, which arm64 could exceed as it doesn't have a
>>>>    single architected NMI. This would be fixed by dropping back to
>>>>    test-and-set when the nesting gets too deep:
>>>>  lore.kernel.org/r/1548215351-18896-1-git-send-email-longman@redhat.com
>>>>
>>>> * Taking an NMI from a KVM guest on arm64 with VHE leaves HCR_EL2.TGE
>>>>   clear, meaning AT and TLBI point at the guest, and PAN/UAO are squiffy.
>>>>   Only TLBI matters for APEI, and this is fixed by Julien's patch:
>>>>  http://lore.kernel.org/r/1548084825-8803-2-git-send-email-julien.thierry@arm.com
>>>>
>>>> * Linux ignores the physical address mask, meaning it doesn't call
>>>>   memory_failure() on all the affected pages if firmware or hypervisor
>>>>   believe in a different page size. Easy to hit on arm64, (easy to fix too,
>>>>   it just conflicts with this series)
>>
>>
>>>> James Morse (26):
>>>>   ACPI / APEI: Don't wait to serialise with oops messages when
>>>>     panic()ing
>>>>   ACPI / APEI: Remove silent flag from ghes_read_estatus()
>>>>   ACPI / APEI: Switch estatus pool to use vmalloc memory
>>>>   ACPI / APEI: Make hest.c manage the estatus memory pool
>>>>   ACPI / APEI: Make estatus pool allocation a static size
>>>>   ACPI / APEI: Don't store CPER records physical address in struct ghes
>>>>   ACPI / APEI: Remove spurious GHES_TO_CLEAR check
>>>>   ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
>>>>   ACPI / APEI: Generalise the estatus queue's notify code
>>>>   ACPI / APEI: Don't allow ghes_ack_error() to mask earlier errors
>>>>   ACPI / APEI: Move NOTIFY_SEA between the estatus-queue and NOTIFY_NMI
>>>>   ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
>>>>   KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
>>>>   arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
>>>>   ACPI / APEI: Move locking to the notification helper
>>>>   ACPI / APEI: Let the notification helper specify the fixmap slot
>>>>   ACPI / APEI: Pass ghes and estatus separately to avoid a later copy
>>>>   ACPI / APEI: Make GHES estatus header validation more user friendly
>>>>   ACPI / APEI: Split ghes_read_estatus() to allow a peek at the CPER
>>>>     length
>>>>   ACPI / APEI: Only use queued estatus entry during
>>>>     in_nmi_queue_one_entry()
>>>>   ACPI / APEI: Use separate fixmap pages for arm64 NMI-like
>>>>     notifications
>>>>   mm/memory-failure: Add memory_failure_queue_kick()
>>>>   ACPI / APEI: Kick the memory_failure() queue for synchronous errors
>>>>   arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work
>>>>   firmware: arm_sdei: Add ACPI GHES registration helper
>>>>   ACPI / APEI: Add support for the SDEI GHES Notification type
>>
>>
>>> I can apply patches in this series up to and including patch [21/26].
>>>
>>> Do you want me to do that?
>>
>> 9-12, 17-19, 21 are missing any review/ack tags, so I wouldn't ask, but as
>> you're offering, yes please!
>>
>>
>>> Patch [22/26] requires an ACK from mm people.
>>>
>>> Patch [23/26] has a problem that randconfig can generate a configuration
>>> in which memory_failure_queue_kick() is not present, so it is necessary
>>> to add a CONFIG_MEMORY_FAILURE dependency somewhere for things to
>>> work (or define an empty stub for that function in case the symbol is
>>> not set).
>>
>> Damn-it! Thanks, I was just trying to work that report out...
>>
>>
>>> If patches [24-26/26] don't depend on the previous two, I can try to
>>> apply them either, so please let me know.
>>
>> 22-24 depend on each other. Merging 24 without the other two is no-improvement,
>> so I'd like them to be kept together.
>>
>> 25-26 don't depend on 22-24, but came later so that they weren't affected by the
>> same race.
>> (note to self: describe that in the cover letter next time.)
>>
>>
>> If I apply the tag's and Boris' changes and post a tested v9 as 1-21, 25-26, is
>> that easier, or does it cause extra work?
> 
> Actually, I went ahead and applied them, since I had the 1-21 ready anyway.

> I applied the Boris' fixups manually which led to a bit of rebasing,
> so please check my linux-next branch.

Looks okay to me, and I ran your branch through the POLL/SEA/SDEI tests I've
been doing for each version so far.


Thanks!

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
