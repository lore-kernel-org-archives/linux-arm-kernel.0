From: leon.woestenberg@gmail.com (Leon Woestenberg)
Date: Wed, 28 Apr 2010 23:34:14 +0200
Subject: PCI Express MSI support on Kirkwood?
In-Reply-To: <20100421131434.GZ4586@mail.wantstofly.org>
References: <r2oc384c5ea1004150237w99d31004r986829697b019e59@mail.gmail.com>
	<g2ic384c5ea1004210555i3ba44b35xf58c233be742be2f@mail.gmail.com>
	<20100421131434.GZ4586@mail.wantstofly.org>
Message-ID: <q2lc384c5ea1004281434x8083ea2ak90c61266d44ee3f7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lennert,

On Wed, Apr 21, 2010 at 3:14 PM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> On Wed, Apr 21, 2010 at 05:55:27AM -0700, Leon Woestenberg wrote:
>>
>> I'm interested in PCI Express MSI support for Linux / Kirkwood, has
>> this been addressed yet in any of the GIT trees?
>
> It hasn't been done yet as far as I know.
>
> I don't think KW was designed with MSI in mind, but it can perhaps be
> done (MSI with up to 16 messages but without multiple message enable,
> or MSI-X with up to 32 system-wide messages) if you use the interrupt
> controller Doorbell interrupts for this purpose.
>
The datasheet mentions support for Root Complex mode as well, but does
not any specific address for the
Message Address Register, so that would mean I could use any
(allocated) piece of system RAM, for example?

"6.1.1 Message Signaled Interrupts (MSI)
Message Signaled Interrupts (MSI) are supported in both Root Complex
and Endpoint modes.
Root Complex mode: The Host sets the PCI Express MSI Message Address Register
                      (Table 288 p. 461) to the same value that it has
set the Endpoint device.
                      A memory write received, with the same address,
is handle as an MSI.
                      Upon receipt of MSI, an interrupt is set in the
<RcvMsi> field in the PCI
                      Express Interrupt Cause Register (Table 320 p.
487). Interrupt data is
                      saved in the PCI Express MSI Message Data Register
                      (Table 290 p. 461).
"



> IOW, make the KW 1M register area available to the PCIe bus via an
> inbound BAR,<...>
>
I wonder if this is necessary after reading 6.1.1 (see above), can you
comment on this?

Do you mean using the BAR0:

"The PCI Express port has its own address map. The PCI Express
interface address map consists of
three Base Address registers (BARs) that map the chip address space.
One BAR is dedicated for
the chip internal registers space."

>
> /me doesn't think he has MSI-capable PCIe cards
>
I have used a cheap Intel PCI Express x1 E1000 Ethernet controller to
verify MSI on several embedded systems before working with custom
hardware.

The E1000 chip works with MSI, if such support is available on the
platform, falls back to legacy interrupts, if not.

Regards,
-- 
Leon
