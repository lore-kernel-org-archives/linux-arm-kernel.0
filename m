Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025AC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3596206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nyT+yBEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3596206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YXN4HV9JqDtl2ytD4R7YAvItPoH7ixmwgUcQSkxGQPI=; b=nyT+yBEI8bYxlA
	DYxary4O9xYAMoxjRzNgecdIif8uwjvZ7NbOK6qVhL+tORpRa4z/zVD0a+7TC5GQ+LHZ2aeeOajX0
	FiGSmKoD5Fr3wmQn/oU4RS3BpOSvE7IcurPLvUytLXYeaI6eOb9dpwZL6eTTZLJPrEJWgB83RF+5T
	LkEKl3xVNmAtuD5y1tkplGKCtyvtEMTCjj4nKCNK6ldGRYwneFWJOYCNrqxvyVdgwy0m1HDz3oldi
	VLWYTIbOnMoETEvLkBnju/ClBRiHCQZdhZRJC2BSCRW7g3TfLr94TxLHGwcLQsyEbP6Eo64ePPf6x
	ohsH8xQFYA27gyVvYxNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghDXq-0001pQ-Rs; Wed, 09 Jan 2019 13:05:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghDXn-0001oy-LF
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:05:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08317A78;
 Wed,  9 Jan 2019 05:05:15 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92A9F3F6CF;
 Wed,  9 Jan 2019 05:05:10 -0800 (PST)
Subject: Re: [RFC][PATCH 2/3] arm64: Define
 Documentation/arm64/elf_at_flags.txt
To: Dave Martin <Dave.Martin@arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <20181210143044.12714-3-vincenzo.frascino@arm.com>
 <20181212173457.GA3505@e103592.cambridge.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <0947d735-c572-834a-efd3-8377d698ac8c@arm.com>
Date: Wed, 9 Jan 2019 13:05:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212173457.GA3505@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_050515_713920_7D2D115F 
X-CRM114-Status: GOOD (  45.72  )
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
 Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>, linux-kselftest@vger.kernel.org,
 Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org,
 Jacob Bramley <Jacob.Bramley@arm.com>, linux-arm-kernel@lists.infradead.org,
 Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>,
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 17:34, Dave Martin wrote:
> On Mon, Dec 10, 2018 at 02:30:43PM +0000, Vincenzo Frascino wrote:
>> On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
>> the userspace (EL0) is allowed to set a non-zero value in the
>> top byte but the resulting pointers are not allowed at the
>> user-kernel syscall ABI boundary.
>>
>> With the relaxed ABI proposed through this document, it is now possible
>> to pass tagged pointers to the syscalls, when these pointers are in
>> memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap() or brk().
> 
> What about other anonymous memory such as the process stack?
>

The process stack is set up by the kernel as a consequence of the exec* family
of system calls in a way that should be transparent to the userspace.
For what concerns the userspace applications, the ones that are aware of the
AT_FLAGS[0] should assume that the stack is always tagged.

> What about MAP_PRIVATE mappings of /dev/zero (i.e., oldskool "anonymous"
> mappings)?
> 

MAP_PRIVATE of /dev/zero is equivalent to MAP_ANONYMOUS | MAP_PRIVATE, hence it
should follow the same rule of MAP_ANONYMOUS obtained memory ranges.

> I wonder whether this should really say MAP_PRIVATE rather than
> MAP_ANONYMOUS.  There are two requirements here:
> 
>  * the memory must be the exclusive property of a single process,
>    otherwise tagging it on-the-fly could break some other process;
> 

I think that it is responsibility of the userspace to tag or not a shared area.
I do not think that we should exclude MAP_ANONYMOUS | MAP_SHARED because if such
an area is tagged improperly by a userspace process, the kernel will be able to
detect the issue and report it.

>  * the memory should be regular memory, i.e., not something like a
>    mapped device.  Since copy-on-write mappings of devices make little
>    sense, and we want writes to devices to propagate to the hardware
>    directly, MAP_PRIVATE doesn't make a lot of sense for such mappings.
> 

What we are trying to target with this ABI change are only pointers in NORMAL
memory ranges. DEVICE memory should be untagged.

...

> I'm assuming here that tagging some currently shared copy-on-write pages
> would throw a page fault and trigger a copy, so that we end up tagging
> the calling process's private copy of the page.
> 
> I also don't see how the above requirements conflict with regular file-
> backed mappings (which would need to work if you want to be able to
> tag objects in .bss or .data etc.)
>

I agree that we should look at the more general cases to make sure that we will
not face any incompatibility in future, but, what I am proposing here, assumes
that the memory areas that can be tagged are only the stack and the heap. This
is because the features that will use it will be mostly looking for memory
related errors in these areas.

>> This change in the ABI requires a mechanism to inform the userspace
>> that such an option is available.
>>
>> This patch specifies and documents the way on which AT_FLAGS can be
>> used to advertise this feature to the userspace.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> CC: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  Documentation/arm64/elf_at_flags.txt | 111 +++++++++++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>  create mode 100644 Documentation/arm64/elf_at_flags.txt
>>
>> diff --git a/Documentation/arm64/elf_at_flags.txt b/Documentation/arm64/elf_at_flags.txt
>> new file mode 100644
>> index 000000000000..153e657c058a
>> --- /dev/null
>> +++ b/Documentation/arm64/elf_at_flags.txt
>> @@ -0,0 +1,111 @@
>> +ARM64 ELF AT_FLAGS
>> +==================
>> +
>> +This document describes the usage and semantics of AT_FLAGS on arm64.
>> +
>> +1. Introduction
>> +---------------
>> +
>> +AT_FLAGS is part of the Auxiliary Vector, contains the flags and it
>> +is currently set to zero by the kernel on arm64.
>> +
>> +The auxiliary vector can be accessed by the userspace using the
>> +getauxval() API provided by the C library.
>> +getauxval() returns an unsigned long and when a flag is present in
>> +the AT_FLAGS, the corresponding bit in the returned value is set to 1.
>> +
>> +The AT_FLAGS with a "defined semantic" on arm64 are exposed to the
>> +userspace via user API (uapi/asm/atflags.h).
>> +The AT_FLAGS bits with "undefined semantics" are set to zero by default.
>> +This means that the AT_FLAGS bits to which this document does not assign
>> +an explicit meaning are to be intended reserved for future use.
>> +The kernel will populate all such bits with zero until meanings are
>> +assigned to them. If and when meanings are assigned, it is guaranteed
>> +that they will not impact the functional operation of existing userspace
>> +software. Userspace software should ignore any AT_FLAGS bit whose meaning
>> +is not defined when the software is written.
>> +
>> +The userspace software can test for features by acquiring the AT_FLAGS
>> +entry of the auxiliary vector, and testing whether a relevant flag
>> +is set.
>> +
>> +Example of a userspace test function:
>> +
>> +bool feature_x_is_present(void)
>> +{
>> +	unsigned long at_flags = getauxval(AT_FLAGS);
>> +	if (at_flags & FEATURE_X)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +Where the software relies on a feature advertised by AT_FLAGS, it
>> +should check that the feature is present before attempting to
>> +use it.
>> +
>> +2. Features exposed via AT_FLAGS
>> +--------------------------------
>> +
>> +bit[0]: ARM64_AT_FLAGS_SYSCALL_TBI
>> +
>> +    On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
>> +    the userspace (EL0) is allowed to set a non-zero value in the top
>> +    byte but the resulting pointers are not allowed at the user-kernel
>> +    syscall ABI boundary.
>> +    When bit[0] is set to 1 the kernel is advertising to the userspace
>> +    that a relaxed ABI is supported hence this type of pointers are now
>> +    allowed to be passed to the syscalls, when these pointers are in
>> +    memory ranges obtained by anonymous (MAP_ANONYMOUS) mmap() or brk().
> 
> "TBI" is a slightly odd name.
> 
> The kernel seems not to be ignoring the top byte, otherwise how could
> it make a difference whehter the memory is anonymous or something else?
> 
> (With memory tagging enabled, the top byte is also not architecturally
> ignored.)
> 

The top-byte is ignored for MMU translations hence it can carry information that
are relevant for other aspects. This means that the kernel can not ignore that
the top-byte could be set.

>> +    In these cases the tag is preserved as the pointer goes through the
>> +    kernel. Only when the kernel needs to check if a pointer is coming
>> +    from userspace (i.e. access_ok()) an untag operation is required.
> 
> Does the last sentence belong here?  That's about kernel internals,
> whereas the rest all seems user-facing.
> 

I put it here just to give an idea to the user on when the kernel is going to
perform an untag operation. But if we want to keep the document completely
user-facing, I am fine with removing it.

>> +
>> +3. ARM64_AT_FLAGS_SYSCALL_TBI
>> +-----------------------------
>> +
>> +When ARM64_AT_FLAGS_SYSCALL_TBI is enabled every syscalls can accept tagged
>> +pointers, when these pointers are in memory ranges obtained by an anonymous
>> +(MAP_ANONYMOUS) mmap() or brk().
>> +
>> +A definition of the meaning of tagged pointers on arm64 can be found in:
>> +Documentation/arm64/tagged-pointers.txt.
>> +
>> +When a pointer does not are in a memory range obtained by an anonymous mmap()
>> +or brk(), this can not be passed to a syscall if it is tagged.
>> +
>> +To be more explicit: a syscall can accept pointers whose memory range is
>> +obtained by a non-anonymous mmap() or brk() if and only if the tag encoded in
>> +the top-byte is 0x00.
>> +
>> +When a new syscall is added, this can accept tagged pointers if and only if
>> +these pointers are in memory ranges obtained by an anonymous (MAP_ANONYMOUS)
>> +mmap() or brk(). In all the other cases, the tag encoded in the top-byte is
>> +expected to be 0x00.
> 
> Does this apply to kernel interfaces that are not syscalls?
> 

Not at the moment, but it does not seem incompatible with a future extension.

> And does it apply to ioctls in general (I think from discussions
> elsewhere that it can't).
> 

Requiring that the pointers accepted by the syscalls belong to ranges that are
obtained by anonymous mappings, should cover the drivers mmap() cases.

> What about things that flow through the kernel, like an
> si_value.sival_ptr that propagates from sigqueue(2) to the signal frame
> of the signalled thread, or registered with the kernel via aio_read(2)?
> 
> This kind of thing is why I would like to define a set of rules for
> making an educated guess about how the kernel should interpret
> arbitrary arguments (in an ideal world).
> 

I think that to make an educated choice we need to restrict the problem we are
trying to target (making sure that we do not take any assumption that could be
incompatible with the general case) as a first step. Once we are confident that
it works as expected we can try to extend it progressively.

> 
> With issues like this in the mix, it seems difficult to extract general
> guarantees from ARM64_AT_FLAGS_SYSCALL_TBI.  If it means that just
> certain specific uses of a few specific syscalls work with tagged
> pointers, that may not be very useful by ifself?  It sounds like if
> you are tagging memory at all, you suddenly need to port every random
> library you're using.
> 

The ABI presented in this document seems quite general (it is not confined to
specific syscalls). This means that an application that tags the memory can use
any non tag aware random library as is (without porting it), as far as it
sanitizes the pointers before and after calling it.

> [...]
> 
> Cheers
> ---Dave
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
