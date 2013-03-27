From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 27 Mar 2013 07:36:36 +0100
Subject: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
In-Reply-To: <20130326222744.54e9fc82@skate>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
 <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
 <20130326222744.54e9fc82@skate>
Message-ID: <20130327063636.GA17821@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 10:27:44PM +0100, Thomas Petazzoni wrote:
[...]
> and so now the suggestions is to do:
> 
>                 pcie-controller {
>                         compatible = "marvell,armada-xp-pcie";
>                         status = "disabled";
>                         device_type = "pci";
> 
>                         #address-cells = <3>;
>                         #size-cells = <2>;
> 
>                         msi-parent = <&msi>;
>                         bus-range = <0x00 0xff>;
> 
> 			ranges = <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000 /* Port 0.0 registers */
> 				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000 /* Port 2.0 registers */
> 				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000 /* Port 0.1 registers */
> 				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000 /* Port 0.2 registers */
> 				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000 /* Port 0.3 registers */
> 				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000 /* Port 1.0 registers */
> 				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000 /* Port 3.0 registers */
> 				  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000 /* Port 1.1 registers */
> 				  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000 /* Port 1.2 registers */
> 				  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000 /* Port 1.3 registers */
> 				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
>                                   0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
> 
>                         pcie at 1,0 {
>                                 device_type = "pci";
> 				assigned-addresses = <0x82000800 0 0xd0040000 0 0x2000>;
>                                 reg = <0x0800 0 0 0 0>;
>                                 #address-cells = <3>;
>                                 #size-cells = <2>;
>                                 #interrupt-cells = <1>;
>                                 interrupt-map-mask = <0 0 0 0>;
>                                 interrupt-map = <0 0 0 0 &mpic 58>;
>                                 marvell,pcie-port = <0>;
>                                 marvell,pcie-lane = <0>;
>                                 clocks = <&gateclk 5>;
>                                 status = "disabled";
>                         };
> 
>                         pcie at 2,0 {
>                                 device_type = "pci";
> 				assigned-addresses = <0x82001000 0 0xd0042000 0 0x2000>;
>                                 reg = <0x1000 0 0 0 0>;
>                                 #address-cells = <3>;
>                                 #size-cells = <2>;
>                                 #interrupt-cells = <1>;
>                                 interrupt-map-mask = <0 0 0 0>;
>                                 interrupt-map = <0 0 0 0 &mpic 59>;
>                                 marvell,pcie-port = <0>;
>                                 marvell,pcie-lane = <1>;
>                                 clocks = <&gateclk 6>;
>                                 status = "disabled";
>                         };
> 
> 			[...]
> 
> 		};
> 
> Is this correct? Thierry, Jason, if you could confirm my understanding,
> that would be great. I could then rework and resend the patch set.

Yes, that looks correct. And as Arnd mentioned the pci at x,y nodes should
probably have an empty ranges property.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/2d6ea44b/attachment-0001.sig>
