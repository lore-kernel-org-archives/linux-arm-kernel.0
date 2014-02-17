From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Feb 2014 08:54:10 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
Message-ID: <20140217075410.GA2633@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 10:40:55AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

>From your other mail:

"[2/5] needs to be reworked to exclude the r8a7790 compatible string."

> +		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";

Why is that? From my knowledge, you start with the exact compatible
property and hardware compatible entries may follow. This is backed up
by Documentation/devicetree/usage-model.txt:

===

The 'compatible' property contains a sorted list of strings starting
with the exact name of the machine, followed by an optional list of
boards it is compatible with sorted from most compatible to least.

===

And from the devicetree wiki [1]:

===

compatible is a list of strings. The first string in the list specifies
the exact device that the node represents in the form
"<manufacturer>,<model>". The following strings represent other devices
that the device is compatible with.

For example, the Freescale MPC8349 System on Chip (SoC) has a serial
device which implements the National Semiconductor ns16550 register
interface. The compatible property for the MPC8349 serial device should
therefore be: compatible = "fsl,mpc8349-uart", "ns16550". In this case,
fsl,mpc8349-uart specifies the exact device, and ns16550 states that it
is register-level compatible with a National Semiconductor 16550 UART.

Note: ns16550 doesn't have a manufacturer prefix purely for historical
reasons. All new compatible values should use the manufacturer prefix.

This practice allows existing device drivers to be bound to a newer
device, while still uniquely identifying the exact hardware.

===

Has this changed?


[1 ]http://www.devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/e0c58044/attachment.sig>
