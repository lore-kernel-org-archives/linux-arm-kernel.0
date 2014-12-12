From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 12 Dec 2014 14:15:58 +0100
Subject: [linux-sunxi] [PATCHv2 0/3] ARM:sunxi:ps2 Added support for
 A10/A20 ps2 controller.
In-Reply-To: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
Message-ID: <548AEA8E.6040100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07-12-14 00:15, vishnupatekar wrote:
> Here is v2 of SUNXI PS2 controller support patch-set as with v1.

So as promised I've run this on an A10 board, with a small fix to
the interrupt property in the sun4i.dtsi file this works as is.

This means that the sun7i compat should be dropped, and the sun4i
compat used everywhere.

I've created 3 fixup patches to do this, note one also renames / moves
the bindings file as it is in the wrong place.

I've attached the 3 fixup patches, pleasesquash these into your
existing patches before posting the next version.

Thanks & Regards,

Hans


>
> Changes in v2:
> 1. added default n depends on ARCH_SUNXI || COMPILE_TEST in Kconfig.
> 2. handled errors and free resources on errors.
> 3. used BIT(x), DIV_ROUND_UP macros.
> 4. corrected style errors.
> 5. added support for A10 also, A10 and A2 have same properties of PS2 controller.
> 6. by default commented ps20 and ps21 nodes,as ps20 pins conflict with HDMI
>     connector on Lime2 Board.
> 7. added compatible as allwinner,sun4i-a10-ps2.
> 8. corrected the possible race condition.
>
> Patch 0 Summary: Allwinner A10/A20 PS2 controller. These modifications are
> 	for PS2 host controller. IBM compliant IBM PS2 and AT-compatible
> 	keyboard and mouse can be connected.
>
> Patch 1 device tree bindings.
>
> Patch 2 adds support for sun7i ps2 driver.
>
> Patch 3 device tree support for PS2 controller.
>   1) Added A10/A20 ps2 nodes to the dtsi
>   2) Added A10/A20 ps2 pinmux to the dtsi
>   3) Added ps2 nodes to the lime2 dts file
>
> vishnupatekar (3):
>    sunxi:dts-bindings:input:ps2 bindings for A10/A20 ps2.
>    sunxi:drivers:input:ps2 Added sunxi A10/A20 ps2 driver
>    ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2 controller.
>
>   .../bindings/input/allwinner,sunxi-ps2.txt         |   23 ++
>   arch/arm/boot/dts/sun4i-a10.dtsi                   |   27 ++
>   arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   13 +
>   arch/arm/boot/dts/sun7i-a20.dtsi                   |   29 ++
>   drivers/input/serio/Kconfig                        |   10 +
>   drivers/input/serio/Makefile                       |    1 +
>   drivers/input/serio/sunxi-ps2.c                    |  364 ++++++++++++++++++++
>   7 files changed, 467 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt
>   create mode 100644 drivers/input/serio/sunxi-ps2.c
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-FIXUP-sunxi-dts-bindings-input-ps2-bindings-for-A10-.patch
Type: text/x-patch
Size: 3234 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/b78f904f/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-FIXUP-sunxi-drivers-input-ps2-Added-sunxi-A10-A20-ps.patch
Type: text/x-patch
Size: 1147 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/b78f904f/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-FIXUP-ARM-dts-sunxi-ps2-dt-nodes-for-A10-A20-PS2-con.patch
Type: text/x-patch
Size: 2258 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/b78f904f/attachment-0005.bin>
