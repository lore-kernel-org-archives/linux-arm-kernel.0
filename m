Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:06:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D19920873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RJZvJ8bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D19920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PhRef2N7VtWSMPaQ9QX3f8PHAPJum9M9BhHwwYyQZyc=; b=RJZvJ8bxauCi/G
	FoD926XY7LwhdWfDl7MDlPFGcl++D+2WrWk3ncGT7atofzXdP9BiybPK5Cmv+zFE6y39TD6Lo/iUI
	MdO5ttbyX59yNl0Xm30FsEJB/gABWlwFE1Zg+kML1fSOq0l1F5q/1z5CLBRl30kD3S3TJLtXpF/KN
	AC2mtzXXstZ24jxoLi1gYwFeCk53yvi8vLAEbAGbt2OpppP/+UWKxvPpSeuxhUf0nX2Pof9w9NVu5
	vgatu89tPAmUfp0f43i2i+Vdmv3G+IRCoMc1dtosfXzdO79xlOb27ODMRB+0njF5qaFyw4NXX2kRW
	BLCKukiGrFcSecXq+PwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9Ph-0003xe-BB; Mon, 11 Feb 2019 11:06:13 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9PZ-0003xD-Mn
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:06:11 +0000
Received: by mail-ot1-f67.google.com with SMTP id i20so16808258otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 03:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zPI7PjhalKapOqadpYNDIzByO1yNXs4bj5jUAy0+XwM=;
 b=eKbKAt0c/+d28ZnnNa7wWYXBHesltzGqJR8zhRbIolwJq/vDlolbuhP0THuHr6mCbk
 BCseMNpYkZEAS/IGN9Y+kqHSqjIp/BWWcx+ZECYFQyPurpHWqYjtClAiNdSvAWt/lCSr
 VPTnI7UWIR4OYk1JQJ8gONr70qgq/nB2BJmZASX641cuqgMEHbxX7jFiKWimDYt6OgML
 46oC+URc1QGXtKYMca7sIh5AArORe6B5GcFs6qWKarzbMLROK+xflWun22W+CeG9sexc
 VbXLCcUCmtSClwIIhhZNJr4fuxGORwUE09MP+DzYikQzGO9OF/O1RKpvSL0/gcdhfwc3
 sPyg==
X-Gm-Message-State: AHQUAuaA1EBAT2HNzFRKsRKdunQ/zPbS3ma1bzOR3nJHrD6Kh5F3AJml
 fhljxMZf2apXCe1l8ZbKleaakD0xkKzn28X/Pms=
X-Google-Smtp-Source: AHgI3IbqhuaLzlFP3vnwI5lQfCp+NTR8q63Sd4/HJ6XtRio15ezN5QQmmTyNqLT2Rmn/CgtqS7GoG3E+06+CFBOjhCA=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr28560952otl.343.1549883164127; 
 Mon, 11 Feb 2019 03:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20190129184902.102850-1-james.morse@arm.com>
 <15200237.N8Ro7ITLGE@aspire.rjw.lan>
 <a8b9983d-5eef-2f30-441f-73ce50da7bca@arm.com>
In-Reply-To: <a8b9983d-5eef-2f30-441f-73ce50da7bca@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Feb 2019 12:05:52 +0100
Message-ID: <CAJZ5v0ibUO7F=+_GBbhEz4nc0jtC=UaK+cOcLCBrXd2pfc0iLg@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] APEI in_nmi() rework and SDEI wire-up
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_030605_739148_33FAF76A 
X-CRM114-Status: GOOD (  28.77  )
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

On Fri, Feb 8, 2019 at 3:13 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Rafael,
>
> On 08/02/2019 11:40, Rafael J. Wysocki wrote:
> > On Tuesday, January 29, 2019 7:48:36 PM CET James Morse wrote:
> >> This series aims to wire-up arm64's fancy new software-NMI notifications
> >> for firmware-first RAS. These need to use the estatus-queue, which is
> >> also needed for notifications via emulated-SError. All of these
> >> things take the 'in_nmi()' path through ghes_copy_tofrom_phys(), and
> >> so will deadlock if they can interact, which they might.
>
> >> Known issues:
> >>  * ghes_copy_tofrom_phys() already takes a lock in NMI context, this
> >>    series moves that around, and makes sure we never try to take the
> >>    same lock from different NMIlike notifications. Since the switch to
> >>    queued spinlocks it looks like the kernel can only be 4 context's
> >>    deep in spinlock, which arm64 could exceed as it doesn't have a
> >>    single architected NMI. This would be fixed by dropping back to
> >>    test-and-set when the nesting gets too deep:
> >>  lore.kernel.org/r/1548215351-18896-1-git-send-email-longman@redhat.com
> >>
> >> * Taking an NMI from a KVM guest on arm64 with VHE leaves HCR_EL2.TGE
> >>   clear, meaning AT and TLBI point at the guest, and PAN/UAO are squiffy.
> >>   Only TLBI matters for APEI, and this is fixed by Julien's patch:
> >>  http://lore.kernel.org/r/1548084825-8803-2-git-send-email-julien.thierry@arm.com
> >>
> >> * Linux ignores the physical address mask, meaning it doesn't call
> >>   memory_failure() on all the affected pages if firmware or hypervisor
> >>   believe in a different page size. Easy to hit on arm64, (easy to fix too,
> >>   it just conflicts with this series)
>
>
> >> James Morse (26):
> >>   ACPI / APEI: Don't wait to serialise with oops messages when
> >>     panic()ing
> >>   ACPI / APEI: Remove silent flag from ghes_read_estatus()
> >>   ACPI / APEI: Switch estatus pool to use vmalloc memory
> >>   ACPI / APEI: Make hest.c manage the estatus memory pool
> >>   ACPI / APEI: Make estatus pool allocation a static size
> >>   ACPI / APEI: Don't store CPER records physical address in struct ghes
> >>   ACPI / APEI: Remove spurious GHES_TO_CLEAR check
> >>   ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
> >>   ACPI / APEI: Generalise the estatus queue's notify code
> >>   ACPI / APEI: Don't allow ghes_ack_error() to mask earlier errors
> >>   ACPI / APEI: Move NOTIFY_SEA between the estatus-queue and NOTIFY_NMI
> >>   ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
> >>   KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
> >>   arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
> >>   ACPI / APEI: Move locking to the notification helper
> >>   ACPI / APEI: Let the notification helper specify the fixmap slot
> >>   ACPI / APEI: Pass ghes and estatus separately to avoid a later copy
> >>   ACPI / APEI: Make GHES estatus header validation more user friendly
> >>   ACPI / APEI: Split ghes_read_estatus() to allow a peek at the CPER
> >>     length
> >>   ACPI / APEI: Only use queued estatus entry during
> >>     in_nmi_queue_one_entry()
> >>   ACPI / APEI: Use separate fixmap pages for arm64 NMI-like
> >>     notifications
> >>   mm/memory-failure: Add memory_failure_queue_kick()
> >>   ACPI / APEI: Kick the memory_failure() queue for synchronous errors
> >>   arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work
> >>   firmware: arm_sdei: Add ACPI GHES registration helper
> >>   ACPI / APEI: Add support for the SDEI GHES Notification type
>
>
> > I can apply patches in this series up to and including patch [21/26].
> >
> > Do you want me to do that?
>
> 9-12, 17-19, 21 are missing any review/ack tags, so I wouldn't ask, but as
> you're offering, yes please!
>
>
> > Patch [22/26] requires an ACK from mm people.
> >
> > Patch [23/26] has a problem that randconfig can generate a configuration
> > in which memory_failure_queue_kick() is not present, so it is necessary
> > to add a CONFIG_MEMORY_FAILURE dependency somewhere for things to
> > work (or define an empty stub for that function in case the symbol is
> > not set).
>
> Damn-it! Thanks, I was just trying to work that report out...
>
>
> > If patches [24-26/26] don't depend on the previous two, I can try to
> > apply them either, so please let me know.
>
> 22-24 depend on each other. Merging 24 without the other two is no-improvement,
> so I'd like them to be kept together.
>
> 25-26 don't depend on 22-24, but came later so that they weren't affected by the
> same race.
> (note to self: describe that in the cover letter next time.)
>
>
> If I apply the tag's and Boris' changes and post a tested v9 as 1-21, 25-26, is
> that easier, or does it cause extra work?

Actually, I went ahead and applied them, since I had the 1-21 ready anyway.

I applied the Boris' fixups manually which led to a bit of rebasing,
so please check my linux-next branch.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
