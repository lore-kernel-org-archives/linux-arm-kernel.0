From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 26 Jun 2015 08:20:47 +0200
Subject: IMX6 - PCIe device tree assignments
In-Reply-To: <CAJ+vNU098bwhdhBPrnCWOy83=oCD0vP+7sRxVcpSGYNu52HDsw@mail.gmail.com>
 (Tim Harvey's message of "Mon, 22 Jun 2015 06:34:37 -0700")
References: <m34mm5tj4b.fsf@t19.piap.pl>
 <CAJ+vNU098bwhdhBPrnCWOy83=oCD0vP+7sRxVcpSGYNu52HDsw@mail.gmail.com>
Message-ID: <m3lhf7q9c0.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your response.

Tim Harvey <tharvey@gateworks.com> writes:

> I became aware of the interrupt mapping side-effect recently of this
> downstream patch as well. I believe the issue is that the pci nodes
> need to be fully described including the interrupt* properties. My
> plan is to address this with a bootloader fixup which will dynamically
> build the device-tree representation of the pcie nodes on the bus
> (because some boards have PCI switches with differing number of
> ports).

Wouldn't it be better if the device tree PCI code accepted the extra
data (basically the "eth1" alias) without changing information which
wasn't explicitly specified (such as IRQ mapping)?

> For now, do not use the down-stream patch and assign the mac addresses
> in a different fashion if using mainline linux on the GW54xx/GW53xx.

That's what I have been doing, though the patch looks like a better,
transparent solution.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
