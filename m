From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Mar 2017 15:06:07 +0100
Subject: [PATCH 06/15] ARM: dts: r8a779x: fix PCI bus dtc warnings
In-Reply-To: <CAL_JsqLd3o0MEgU93axvEg3kddMp4fvP2ZpnBWRdNBR8AHFV+Q@mail.gmail.com>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-6-robh@kernel.org>
 <CAMuHMdVMyjVv471KB6+SCbNBs6EAaFUm1-2xwj2y-qgriFht0Q@mail.gmail.com>
 <CAL_JsqLd3o0MEgU93axvEg3kddMp4fvP2ZpnBWRdNBR8AHFV+Q@mail.gmail.com>
Message-ID: <CAMuHMdWhcix=rSQMB5Vf6jN_3_RfrHBMwmVLW4tjP_9bLpVMMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Mar 22, 2017 at 2:47 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 22, 2017 at 3:58 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Mar 22, 2017 at 3:03 AM, Rob Herring <robh@kernel.org> wrote:
>>> dtc recently added PCI bus checks. Fix these warnings.
>>
>> It's always a good idea to put the warnings in the commit message:
>
> Well, the warnings are a bit noisy in that they get repeated, can be
> misleading, change as I fix problems (device nodes are not checked if
> the bridge node fails), and most importantly I'm lazy having fixed
> these treewide. Sub-arch maintainers are welcome to make better
> patches. :)
>
>> arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
>> /pci at ee090000/usb at 0,1 node name is not "pci" or "pcie"

[...]

>> The above indeed go away with your patch, but I don't know why ;-)
>
> Most of these are because 'device_type = "pci";' should only be on PCI
> bridges, not PCI devices.

Thanks, retrying...

arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Node
/pci at ee090000/usb at 0,1 PCI unit address format error, expected "1,0"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Node
/pci at ee090000/usb at 0,2 PCI unit address format error, expected "2,0"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Node
/pci at ee0d0000/usb at 0,1 PCI unit address format error, expected "1,0"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Node
/pci at ee0d0000/usb at 0,2 PCI unit address format error, expected "2,0"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_bus_num):
Node /pci at ee0d0000/usb at 0,1 PCI bus number 0 out of range, expected (2
- 2)
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_bus_num):
Node /pci at ee0d0000/usb at 0,2 PCI bus number 0 out of range, expected (2
- 2)

OK, without 'device_type = "pci"' it makes much more sense...

>> Both Documentation/devicetree/bindings/pci/pci.txt and ePAPR refer to
>> http://www.firmware.org/1275/bindings/pci/pci2_1.pdf
>> http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
>> which no longer exist.
>
> Yeah, they are still out there. Just need to google "PCI supplement 1275". :)
>
> I have the full archive saved off. I need to get them added to devicetree.org.

Having working links in the DT bindings would be great.

BTW, seems like I still have an offline copy of v2.0 of the PCI spec in
PostScript format, from my CHRP days[*], when hard disks where smaller
than CD-Rs ;-)

[*] I never managed to memorize the PCI DT bindings, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
