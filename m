From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:32:25 +0100
Subject: [PATCH 0/3] ARM: sun9i: Add support for PRCM on Allwinner A80 SoC
In-Reply-To: <1425349320-2754-1-git-send-email-wens@csie.org>
References: <1425349320-2754-1-git-send-email-wens@csie.org>
Message-ID: <20150308173225.GK5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Tue, Mar 03, 2015 at 10:21:57AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> Some time ago I sent out an RFC series, which was not merged due
> to lack of matching documentation for the SoC. A few weeks back I
> sent out a request for the documents again. I have not received a
> response. So I'm sending out the series now.
> 
> This series adds support for the Power Reset and Clock Management
> module on Allwinner's A80 SoC. The PRCM manages clocks and resets
> for the "special" block of peripherals, or the R/RTC block in
> earlier SoCs. These peripherals include a standby processor core,
> a timer block, a watchdog, pin controller, 1 wire interface, PS/2
> interface, a UART, the RSB controller, a DMA controller, a consumer
> IR receiver block, 2 I2C controllers, and 2 I2S controllers. We do
> not have documents for all the peripherals. Support will be added
> where possible.
> 
> 
> Patch 1 adds support for the apbs (apb0 in earlier SoCs) gates.
> 
> Patch 2 adds sun9i-a80 support to the PRCM mfd driver
> 
> Patch 3 adds the clock and reset nodes for the PRCM to the A80 DTSI.

These three patches look fine to me. Have you seen that the new
bootloader code has some interesting infos about RSB and PRCM?

If so, does it match what you did so far?

> To Allwinner people:
> If you have any related documents or comments, please send them out.

Kevin, Shuge, your input would be greatly appreciated.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/15daee82/attachment.sig>
