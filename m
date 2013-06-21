From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Jun 2013 10:56:29 -0400
Subject: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
In-Reply-To: <51C46001.30500@gmail.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com>
 <20130621140707.GO31667@titan.lakedaemon.net>
 <51C46001.30500@gmail.com>
Message-ID: <20130621145629.GQ31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 04:15:29PM +0200, Sebastian Hesselbarth wrote:
> On 06/21/13 16:07, Jason Cooper wrote:
> >On Fri, Jun 21, 2013 at 03:32:09PM +0200, Gregory CLEMENT wrote:
> >>The mv64xxx-i2c embedded in the Armada XP have a new feature to
> >>offload i2c transaction. This new version of the IP come also with
> >>some errata. This lead to the introduction to a another compatible
> >>string.
> >>
> >>This commit split the i2c information into armada-370.dtsi and
> >>armada-xp.dtsi. Most of the data remains the same and stay in the
> >>common file Armada-370-xp.dtsi. With this new feature the size of the
> >>registers are bigger for Armada XP and the new compatible string is
> >>used.
> >>
> >>The Device Tree binding documentation is updated accordingly.
> >>
> >>Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >>---
> >>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 13 ++++++++++++-
> >>  arch/arm/boot/dts/armada-370-xp.dtsi                  |  2 --
> >>  arch/arm/boot/dts/armada-370.dtsi                     |  8 ++++++++
> >>  arch/arm/boot/dts/armada-xp.dtsi                      | 10 ++++++++++
> >>  4 files changed, 30 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> >>index a1ee681..ce7af6a 100644
> >>--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> >>+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> >>@@ -4,7 +4,8 @@
> >>  Required properties :
> >>
> >>   - reg             : Offset and length of the register set for the device
> >>- - compatible      : Should be "marvell,mv64xxx-i2c"
> >>+ - compatible      : Should be "marvell,mv64xxx-i2c" and "marvell,mv7230-i2c"
> >>+for controller which support the I2C Transaction Generator
> 
> Jason, Gregory,
> 
> Also, s/mv7230/mv78230/

noted.

> from a quick check of the patch set (which you forgot to send to LKML)
> I am wondering why you didn't update the of matches struct with the new
> compatible for "marvell,mv78230-i2c"? This will save you from still
> having "marvell,mv64xxx-i2c" as additional compatible to match device
> and driver. With that the above should also be s/and/or/.

agreed, good point.

Gregory,

I'm sending the last PRs for mvebu today.  I'll include this one with my
suggestion and Sebastian's if you're ok with it.  That means you'll have
to respin the series for the i2c folks.  Does that work for you?

thx,

Jason.

> >>   - interrupts      : The interrupt number
> >>
> >>  Optional properties :
> >>@@ -20,3 +21,13 @@ Examples:
> >>  		interrupts = <29>;
> >>  		clock-frequency = <100000>;
> >>  	};
> >>+
> >>+For a controller which support the I2C Transaction Generator:
> >>+
> >>+	i2c at 11000 {
> >>+		compatible = "marvell,mv64xxx-i2c", "marvell,mv78230-i2c";
> >>+		reg = <0x11000 0x100>;
> >>+		compatible = "marvell,mv64xxx-i2c";
> >
> >extra compatible line.  If there's nothing else, I'll fix this up when I
> >pull it in.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
