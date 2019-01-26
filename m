Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F59CC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:34:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB97B218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNv+zePr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB97B218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1O7Ft+a2OpuFF6uTM1ejISw/P/v/QlSAAVA32e4dmcM=; b=WNv+zePrycCZ9X
	881+Pi+SUIrXL+0AnMPBP9APfup7CRs/v6OZpT+2SjgOHYBIVkTjPzq6CUL2RIbuBa9V3hvZw3u0K
	9Xe7p+l0R7FbttdSHzMSfi+I6yShEPbJ73ZeQ9VZKha78crEpklxjKTA/+QFg4ydU5qN00oOAL2D2
	3PxuBd9jEQup1QkpgfmFLeiOYzVj9OGAsLJ4bl6JeRfWGZcwKp/mt1n6HObJaH7V23t5lfuWQeij6
	eQpwJKxDkGpbTQvQ+tp4cr/YVAJ8BFUQXJ4nKl+QAFGJvbdm5G0JIuuSnVyTd8GHYKvEw6YvytALd
	jG7eEt9GeSdxKGfrF77g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnNA7-0007Gj-NU; Sat, 26 Jan 2019 12:34:15 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnNA4-0007GG-8S
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 12:34:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DD955ACD3;
 Sat, 26 Jan 2019 12:34:07 +0000 (UTC)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
From: Alexander Graf <agraf@suse.de>
X-Mailer: iPhone Mail (16D39)
In-Reply-To: <CAKv+Gu9Cz5AW6o_FWxaGOeWsTN_AveiuNQkMhiDT5U-mZ1r91g@mail.gmail.com>
Date: Sat, 26 Jan 2019 13:34:06 +0100
Message-Id: <47E85138-58E2-434B-8D78-525DF5A2E7E0@suse.de>
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
 <496259a6-f277-77b3-e5d2-7d45b4f515c7@gmx.de>
 <CAKv+Gu9Cz5AW6o_FWxaGOeWsTN_AveiuNQkMhiDT5U-mZ1r91g@mail.gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_043412_592161_6FB9D110 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-efi <linux-efi@vger.kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Will Deacon <will.deacon@arm.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> Am 26.01.2019 um 13:28 schrieb Ard Biesheuvel <ard.biesheuvel@linaro.org>:
> 
>> On Sat, 26 Jan 2019 at 13:27, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>> 
>>> On 1/26/19 11:22 AM, Ard Biesheuvel wrote:
>>> The UEFI spec revision 2.7 errata A section 8.4 has the following to
>>> say about the virtual memory runtime services:
>>> 
>>>  "This section contains function definitions for the virtual memory
>>>  support that may be optionally used by an operating system at runtime.
>>>  If an operating system chooses to make EFI runtime service calls in a
>>>  virtual addressing mode instead of the flat physical mode, then the
>>>  operating system must use the services in this section to switch the
>>>  EFI runtime services from flat physical addressing to virtual
>>>  addressing."
>>> 
>>> So it is pretty clear that calling SetVirtualAddressMap() is entirely
>>> optional, and so there is no point in doing so unless it achieves
>>> anything useful for us.
>>> 
>>> This is not the case for 64-bit ARM. The native mapping used by the OS
>>> is arbitrarily converted into another permutation of userland addresses
>>> (i.e., bits [63:48] cleared), and the runtime code could easily deal
>>> with the original layout in exactly the same way as it deals with the
>>> converted layout. However, due to constraints related to page size
>>> differences if the OS is not running with 4k pages, and related to
>>> systems that may expose the individual sections of PE/COFF runtime
>>> modules as different memory regions, creating the virtual layout is a
>>> bit fiddly, and requires us to sort the memory map and reason about
>>> adjacent regions with identical memory types etc etc.
>>> 
>>> So the obvious fix is to stop calling SetVirtualAddressMap() altogether
>>> on arm64 systems. However, to avoid surprises, which are notoriously
>>> hard to diagnose when it comes to OS<->firmware interactions, let's
>>> start by making it an opt-out feature, and implement support for the
>>> 'efi=novamap' kernel command line parameter on ARM and arm64 systems.
>>> 
>>> (Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
>>> used, given that the physical memory map and the kernel virtual address
>>> map are not guaranteed to be non-overlapping like on arm64. However,
>>> having support for efi=novamap,noruntime on 32-bit ARM, combined with
>>> the recently proposed support for earlycon=efi, is likely to be useful
>>> to diagnose boot issues on such systems if they have no accessible serial
>>> port)
>>> 
>> 
>> NAK
>> 
> 
> Excuse me?
> 
>> This patch breaks EFI booting with any known U-Boot release.
>> 
> 
> It does if you pass 'efi=novmap'. Otherwise, it works fine.

Even then it doesn't break the entire boot, only runtime services (which are guarded anyway). I would claim that in most cases, we do not break even.

Alex



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
