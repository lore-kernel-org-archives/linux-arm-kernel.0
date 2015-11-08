From: hgkr.klein@gmail.com (Helmut Klein)
Date: Sun, 8 Nov 2015 12:16:57 +0100
Subject: wrong value in kirkwood-ts219.dtsi
In-Reply-To: <20151104151227.GA3316@lunn.ch>
References: <56390400.5070408@gmail.com> <20151103203628.GA25118@lunn.ch>
 <5639EC29.8010604@gmail.com> <20151104151227.GA3316@lunn.ch>
Message-ID: <563F2F29.8040005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Andrew,

i've appended a text, which might be a "canonical patch".

regards
Helmut


Subject: arm: make QNAP power-off work for ts219 with an appended dt blob

the "reg" entry in the "poweroff" section of "kirkwood-ts219.dtsi"
addressed the wrong uart (0 = console). this patch changes the address to
select uart 1. this is the uart connected to the pic microcontroller,
which can switch the device off.
Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
---
--- linux-4.3/arch/arm/boot/dts/kirkwood-ts219.dtsi.orig
+++ linux-4.3/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -40,7 +40,7 @@
};
poweroff at 12100 {
compatible = "qnap,power-off";
- reg = <0x12000 0x100>;
+ reg = <0x12100 0x100>;
clocks = <&gate_clk 7>;
};
spi at 10600 {


On 04.11.2015 16:12, Andrew Lunn wrote:
> On Wed, Nov 04, 2015 at 12:29:45PM +0100, Helmut Klein wrote:
>> Hallo Andrew,
>>
>> here is the patch (created with diff -up and then compressed with xz)
>
> Thanks.
>
> But unfortunately, there is a lot more process involved.  Please could
> you take a look at Documentation/SubmittingPatches in the kernel
> sources.
>
> 	Andrew
>
