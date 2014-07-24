From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 24 Jul 2014 11:48:00 -0700
Subject: (request for -mm inclusion) Re: [PATCH v3] arm64, ia64, ppc, s390, sh,
 tile, um, x86, mm: Remove default gate area
Message-ID: <CALCETrURqjZQbRk-UJoeEXwJJCL=dBtoRt8_S0qF3a2mZJdgrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi akpm-

One more try before I spam the world with a new thread.  Is this patch
okay for -mm?

So far, it's accumulated:

Acked-by: Nathan Lynch <nathan_lynch@mentor.com>
Acked-by: H. Peter Anvin <hpa@linux.intel.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org> [in principle]
Acked-by: Richard Weinberger <richard@nod.at> [for um]
Acked-by: Will Deacon <will.deacon@arm.com> [for arm64]

For convenience, I've attached the patch w/ the acked-by's folded in
and with no other changes.

Thanks,
Andy


On Fri, Jul 18, 2014 at 9:53 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Jul 18, 2014 3:20 AM, "Richard Weinberger" <richard@nod.at> wrote:
>>
>> Am 18.07.2014 12:14, schrieb Will Deacon:
>> > On Tue, Jul 15, 2014 at 03:47:26PM +0100, Andy Lutomirski wrote:
>> >> On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski <luto@amacapital.net>
>> >> wrote:
>> >>> The core mm code will provide a default gate area based on
>> >>> FIXADDR_USER_START and FIXADDR_USER_END if
>> >>> !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
>> >>>
>> >>> This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
>> >>> 64-bit UML, and x86_32 have their own code just to disable it.  arm,
>> >>> 32-bit UML, and x86_64 have gate areas, but they have their own
>> >>> implementations.
>> >>>
>> >>> This gets rid of the default and moves the code into ia64.
>> >>>
>> >>> This should save some code on architectures without a gate area: it's
>> >>> now possible to inline the gate_area functions in the default case.
>> >>
>> >> Can one of you pull this somewhere?  Otherwise I can put it somewhere
>> >> stable and ask for -next inclusion, but that seems like overkill for a
>> >> single patch.
>>
>> For the um bits:
>> Acked-by: Richard Weinberger <richard@nod.at>
>>
>> > I'd be happy to take the arm64 part, but it doesn't feel right for mm/*
>> > changes (or changes to other archs) to go via our tree.
>> >
>> > I'm not sure what the best approach is if you want to send this via a
>> > single
>> > tree. Maybe you could ask akpm nicely?
>>
>> Going though Andrew's tree sounds sane to me.
>
> Splitting this will be annoying: I'd probably have to add a flag asking for
> the new behavior, update all the arches, then remove the flag.  The chance
> of screwing up bisectability in the process seems pretty high.  This seems
> like overkill for a patch that mostly deletes code.
>
> Akpm, can you take this?
>
> --Andy
>
>>
>> Thanks,
>> //richard



-- 
Andy Lutomirski
AMA Capital Management, LLC
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm64-ia64-ppc-s390-sh-tile-um-x86-mm-Remove-default.patch
Type: text/x-diff
Size: 14779 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/1b55ab1f/attachment-0001.bin>
