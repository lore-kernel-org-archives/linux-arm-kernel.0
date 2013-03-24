From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 23 Mar 2013 21:22:04 -0300
Subject: [PATCH v2 13/14] ARM: mvebu: Add thermal support to Armada 370
 device tree
In-Reply-To: <514DBB76.4080006@cogentembedded.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363991114-4225-14-git-send-email-ezequiel.garcia@free-electrons.com>
 <514DB9B9.8090601@cogentembedded.com>
 <514DBA1F.6050701@cogentembedded.com>
 <514DBB76.4080006@cogentembedded.com>
Message-ID: <20130324002203.GB3269@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 06:25:58PM +0400, Sergei Shtylyov wrote:
> On 23-03-2013 18:20, Sergei Shtylyov wrote:
> 
> >>> This patch adds support for the thermal controller available in
> >>> all Armada 370 boards. This controller has two 4-byte registers:
> >>> one to read the thermal sensor, the other for sensor initialization.
> 
> >>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >>> ---
> >>> This patch depends on the patch to add Armada 370 support
> >>> in the mvebu_thermal driver:
> >>> 'thermal: mvebu: Add support for Armada 370 thermal sensor'
> 
> >>>   arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
> >>>   1 files changed, 6 insertions(+), 0 deletions(-)
> 
> >>> diff --git a/arch/arm/boot/dts/armada-370.dtsi
> >>> b/arch/arm/boot/dts/armada-370.dtsi
> >>> index 8188d13..5831994 100644
> >>> --- a/arch/arm/boot/dts/armada-370.dtsi
> >>> +++ b/arch/arm/boot/dts/armada-370.dtsi
> >>> @@ -153,5 +153,11 @@
> >>>               clocks = <&coreclk 0>;
> >>>           };
> >>>
> >>> +        thermal at d0018300 {
> >>> +            compatible = "marvell,armada370-thermal";
> >>> +            reg = <0xd0018300 0x4
> >>> +                   0xd0018304 0x4>;
> 
> >>     As the two registers are adjacent to each other, why have two register
> >> regions ISO one?
> 
> >     Ah, I just saw the previous patch where the registers are not adjacent and
> > it became clear why.
> 
>     However, the "compatible" properties are different...
> 

Well, the compatible maybe different, but they belong to the same family
(i.e. same driver).

IMHO, it doesn't matter whether the registers are adjacents or not
as they have different meanings, as clearly stated in the device tree
binding documentation: the first register is for the sensor, and second
one (which is optional) is for the calibration.

Do you think this is confusing?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
