From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 26 Jun 2015 06:19:36 -0700
Subject: IMX6 - PCIe device tree assignments
In-Reply-To: <m3lhf7q9c0.fsf@t19.piap.pl>
References: <m34mm5tj4b.fsf@t19.piap.pl>
 <CAJ+vNU098bwhdhBPrnCWOy83=oCD0vP+7sRxVcpSGYNu52HDsw@mail.gmail.com>
 <m3lhf7q9c0.fsf@t19.piap.pl>
Message-ID: <CAJ+vNU27NFsB=LCOyuaU1r=9KBuQK3oKkeUMeg26BfUnbyFbbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 11:20 PM, Krzysztof Ha?asa <khalasa@piap.pl> wrote:
> Thanks for your response.
>
> Tim Harvey <tharvey@gateworks.com> writes:
>
>> I became aware of the interrupt mapping side-effect recently of this
>> downstream patch as well. I believe the issue is that the pci nodes
>> need to be fully described including the interrupt* properties. My
>> plan is to address this with a bootloader fixup which will dynamically
>> build the device-tree representation of the pcie nodes on the bus
>> (because some boards have PCI switches with differing number of
>> ports).
>
> Wouldn't it be better if the device tree PCI code accepted the extra
> data (basically the "eth1" alias) without changing information which
> wasn't explicitly specified (such as IRQ mapping)?

Yes - and this is how I originally had thought/hoped it worked. I
haven't had time to dig into the interrupt mapping issue that the
downstream patch referenced causes so its possible I'm making a bad
assumption and its something else.

>
>> For now, do not use the down-stream patch and assign the mac addresses
>> in a different fashion if using mainline linux on the GW54xx/GW53xx.
>
> That's what I have been doing, though the patch looks like a better,
> transparent solution.

I agree - there should be a simple way for the bootloader firmware to
get mac addresses to the kernel (without having to know fully where it
sits on the bus IMHO so you don't have to have full PCI support in the
bootloader). I will be sure to cc you when I can get to it and come up
with a better solution (whether its an upstream linux device-tree
change for GW54xx/GW53xx or if its a bootloader firmware fix).

Tim
