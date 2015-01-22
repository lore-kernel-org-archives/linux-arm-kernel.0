From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Jan 2015 17:47:25 -0600
Subject: [PATCH 00/16] PCI generic configuration space accessors
In-Reply-To: <20150122210344.GE13072@google.com>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
 <20150122210344.GE13072@google.com>
Message-ID: <CAL_Jsq+aw0y-1rrF=RMpYKMP4zGfmqzzG5BXYYoFABtKEUpX8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 3:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jan 09, 2015 at 08:34:34PM -0600, Rob Herring wrote:
>> This series adds common accessor functions for PCI configuration space
>> accesses. This supports most PCI hosts with memory mapped configuration
>> space like ECAM or hosts with memory mapped address/data registers. ECAM
>> is not generically supported by this series, but could be added on top
>> of this. While some hosts have standard address decoding which could be
>> common as well, the various checks on bus numbers and device numbers are
>> quite varied. It is unclear how much of that is really necessary or
>> could be common.
>>
>> The first 4 patches are preparatory cleanup. Patch 5 introduces the
>> common accessors. The remaining patches convert several PCI host
>> controllers. This is in no way a complete list of host controllers. The
>> conversion of more hosts should be possible. The Designware controller
>> in particular should be able to be converted, but its config space
>> accessors are a mess of override-able functions that I've not gotten my
>> head around.

[...]

> Really nice cleanups.  I added these with the acks so far to a pci/config
> branch for v3.20.  I'll update it with more acks if they trickle in.

Thanks.

> You've structured it nicely so I can also just drop individual arch pieces
> if necessary.  The pieces that haven't been acked yet (hint, hint):
>
>     arch/arm/mach-cns3xxx/pcie.c
>     arch/arm/mach-sa1100/pci-nanoengine.c

Some ARM sub-arch maintainers tend to not respond on things. These are
platforms which aren't very active and aren't going to move to
drivers/pci/host/ anytime soon. Maybe Arnd wants to ack them.

>     arch/mn10300/unit-asb2305/pci.c
>     arch/powerpc
>
> In addition, nobody has acked the frv and mips parts, but they're trivial
> (they only add struct member names) that I can apply them without worrying.

You must pick-up the 4 clean-up ones or the build will break for those
platforms. Or perhaps that will encourage some acks.

I've also got some actual conversions for some MIPS platforms in my
tree I haven't sent out yet. MIPS is fun with all the variety of
endianness and h/w swapping capability or not.

Rob
