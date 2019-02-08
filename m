Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83935C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECA12146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8DE7Gf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kGhBm1KREtGNFAt4r+S9/GCSomLiARMG07j9bRrwtv0=; b=V8DE7Gf9wmKrEz
	6I9ilqIn2nUsqHDpBPRX+X85PB+omrjOwhsCv8tiooebfmf55gbCaasHiVlGzOKYN6fCPp+HiwxIY
	7YG1qCcm4j2elJdIwOONjoVZYz97Usb9e/c2EtNpwtDLDn5tl4KqigL/vLZeuRDRL/f7bZjCsS7BP
	WnTX0aMySAT8cUGKyPe/LgCvmcfV+h7uz1KKPvy3sJWUZ2nDdnLC/vXzkUjLeLQ/TLkdmHigTGZPE
	DxNvpp87i+95EvIpObWM/Tdr4P67lApJVckd3TsCKeDn24VLgMXQSASC5HNLc93ODJiksZ1qET98e
	vkjNTxM5vMNpHpDQjMSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6up-0007nd-FB; Fri, 08 Feb 2019 14:14:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6ul-0007nC-Tu
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:14:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D82A78;
 Fri,  8 Feb 2019 06:13:57 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3706A3F557;
 Fri,  8 Feb 2019 06:13:55 -0800 (PST)
Subject: Re: [PATCH v8 00/26] APEI in_nmi() rework and SDEI wire-up
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>
References: <20190129184902.102850-1-james.morse@arm.com>
 <15200237.N8Ro7ITLGE@aspire.rjw.lan>
From: James Morse <james.morse@arm.com>
Message-ID: <a8b9983d-5eef-2f30-441f-73ce50da7bca@arm.com>
Date: Fri, 8 Feb 2019 14:13:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <15200237.N8Ro7ITLGE@aspire.rjw.lan>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_061359_972026_B1DB8B30 
X-CRM114-Status: GOOD (  23.44  )
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
Cc: Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rafael,

On 08/02/2019 11:40, Rafael J. Wysocki wrote:
> On Tuesday, January 29, 2019 7:48:36 PM CET James Morse wrote:
>> This series aims to wire-up arm64's fancy new software-NMI notifications
>> for firmware-first RAS. These need to use the estatus-queue, which is
>> also needed for notifications via emulated-SError. All of these
>> things take the 'in_nmi()' path through ghes_copy_tofrom_phys(), and
>> so will deadlock if they can interact, which they might.

>> Known issues:
>>  * ghes_copy_tofrom_phys() already takes a lock in NMI context, this
>>    series moves that around, and makes sure we never try to take the
>>    same lock from different NMIlike notifications. Since the switch to
>>    queued spinlocks it looks like the kernel can only be 4 context's
>>    deep in spinlock, which arm64 could exceed as it doesn't have a
>>    single architected NMI. This would be fixed by dropping back to
>>    test-and-set when the nesting gets too deep:
>>  lore.kernel.org/r/1548215351-18896-1-git-send-email-longman@redhat.com
>>
>> * Taking an NMI from a KVM guest on arm64 with VHE leaves HCR_EL2.TGE
>>   clear, meaning AT and TLBI point at the guest, and PAN/UAO are squiffy.
>>   Only TLBI matters for APEI, and this is fixed by Julien's patch:
>>  http://lore.kernel.org/r/1548084825-8803-2-git-send-email-julien.thierry@arm.com
>>
>> * Linux ignores the physical address mask, meaning it doesn't call
>>   memory_failure() on all the affected pages if firmware or hypervisor
>>   believe in a different page size. Easy to hit on arm64, (easy to fix too,
>>   it just conflicts with this series)


>> James Morse (26):
>>   ACPI / APEI: Don't wait to serialise with oops messages when
>>     panic()ing
>>   ACPI / APEI: Remove silent flag from ghes_read_estatus()
>>   ACPI / APEI: Switch estatus pool to use vmalloc memory
>>   ACPI / APEI: Make hest.c manage the estatus memory pool
>>   ACPI / APEI: Make estatus pool allocation a static size
>>   ACPI / APEI: Don't store CPER records physical address in struct ghes
>>   ACPI / APEI: Remove spurious GHES_TO_CLEAR check
>>   ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
>>   ACPI / APEI: Generalise the estatus queue's notify code
>>   ACPI / APEI: Don't allow ghes_ack_error() to mask earlier errors
>>   ACPI / APEI: Move NOTIFY_SEA between the estatus-queue and NOTIFY_NMI
>>   ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
>>   KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
>>   arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
>>   ACPI / APEI: Move locking to the notification helper
>>   ACPI / APEI: Let the notification helper specify the fixmap slot
>>   ACPI / APEI: Pass ghes and estatus separately to avoid a later copy
>>   ACPI / APEI: Make GHES estatus header validation more user friendly
>>   ACPI / APEI: Split ghes_read_estatus() to allow a peek at the CPER
>>     length
>>   ACPI / APEI: Only use queued estatus entry during
>>     in_nmi_queue_one_entry()
>>   ACPI / APEI: Use separate fixmap pages for arm64 NMI-like
>>     notifications
>>   mm/memory-failure: Add memory_failure_queue_kick()
>>   ACPI / APEI: Kick the memory_failure() queue for synchronous errors
>>   arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work
>>   firmware: arm_sdei: Add ACPI GHES registration helper
>>   ACPI / APEI: Add support for the SDEI GHES Notification type


> I can apply patches in this series up to and including patch [21/26].
> 
> Do you want me to do that?

9-12, 17-19, 21 are missing any review/ack tags, so I wouldn't ask, but as
you're offering, yes please!


> Patch [22/26] requires an ACK from mm people.
> 
> Patch [23/26] has a problem that randconfig can generate a configuration
> in which memory_failure_queue_kick() is not present, so it is necessary
> to add a CONFIG_MEMORY_FAILURE dependency somewhere for things to
> work (or define an empty stub for that function in case the symbol is
> not set).

Damn-it! Thanks, I was just trying to work that report out...


> If patches [24-26/26] don't depend on the previous two, I can try to
> apply them either, so please let me know.

22-24 depend on each other. Merging 24 without the other two is no-improvement,
so I'd like them to be kept together.

25-26 don't depend on 22-24, but came later so that they weren't affected by the
same race.
(note to self: describe that in the cover letter next time.)


If I apply the tag's and Boris' changes and post a tested v9 as 1-21, 25-26, is
that easier, or does it cause extra work?


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
