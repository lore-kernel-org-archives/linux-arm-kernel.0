From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Feb 2017 15:20:52 +0000
Subject: [PATCH v4] efi: arm64: Add vmlinux debug link to the Image binary
In-Reply-To: <20170203151728.GB23547@arm.com>
References: <1486056799-4825-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170202183000.GN13839@arm.com>
 <CAKv+Gu82NmBNavpVQ8z7xZ6++HPqAWNnn3dM=dKw0JaWLZocSw@mail.gmail.com>
 <CAKv+Gu9VmbjtvFVveAXiRtpBtZCWJV6pMGmnEzTc5gPrOnYvnQ@mail.gmail.com>
 <20170203151728.GB23547@arm.com>
Message-ID: <CAKv+Gu__3zh42t1+H4ivU+jy2vcwnEOTWEA93kmvWfkok++ojw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2017 at 15:17, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Feb 03, 2017 at 02:50:40PM +0000, Ard Biesheuvel wrote:
>> On 2 February 2017 at 18:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 2 February 2017 at 18:30, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Thu, Feb 02, 2017 at 05:33:19PM +0000, Ard Biesheuvel wrote:
>> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> > index 2600c60337ac..1606c6b2a280 100644
>> > --- a/arch/arm64/kernel/Makefile
>> > +++ b/arch/arm64/kernel/Makefile
>> > @@ -57,5 +57,5 @@ head-y                                        := head.o
>> >  extra-y                                        += $(head-y) vmlinux.lds
>> >
>> >  ifeq ($(CONFIG_DEBUG_EFI),y)
>> > -AFLAGS_head.o += -DVMLINUX_PATH="\"$(shell readlink -f $(objtree)/vmlinux)\""
>> > +AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
>> >  endif
>> >
>> >
>> >> Do you want me to merge this via arm64?
>> >>
>> >
>> > Yes, please
>>
>> Should I respin this?
>
> No need, I'll pick it up and make the change. I'll push out before I leave
> work this evening.
>

Cheers
