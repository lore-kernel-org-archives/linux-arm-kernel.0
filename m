From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Mar 2016 11:13:51 +0100
Subject: [PATCH] ARM: bcm2835: add CPU node for ARM core
In-Reply-To: <56FA5332.4050707@i2se.com>
References: <1459182081-30819-1-git-send-email-stefan.wahren@i2se.com>
 <20160329094158.GB26574@leverpostej> <56FA5332.4050707@i2se.com>
Message-ID: <20160329101351.GC26574@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 12:04:34PM +0200, Stefan Wahren wrote:
> Am 29.03.2016 um 11:41 schrieb Mark Rutland:
> > On Mon, Mar 28, 2016 at 04:21:20PM +0000, Stefan Wahren wrote:
> >> This patch adds the CPU node of the BCM2835 into the DT.
> >>
> >> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >> ---
> >>  arch/arm/boot/dts/bcm2835.dtsi |   11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> >> index b83b326..e87aba1 100644
> >> --- a/arch/arm/boot/dts/bcm2835.dtsi
> >> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> >> @@ -3,6 +3,17 @@
> >>  / {
> >>  	compatible = "brcm,bcm2835";
> >>  
> >> +	cpus {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		cpu at 0 {
> >> +			device_type = "cpu";
> >> +			compatible = "arm,arm1176jzf-s", "arm,arm1176";
> >> +			reg = <0x0>;
> >> +		};
> >> +	};
> > Minor nit: the "arm,arm1176" fallback isn't documented, nor used
> > elsewhere, so it can/should be dropped.
> 
> This fallback came from arch/arm/boot/dts/s3c64xx.dtsi

Ah, indeed. I failed to spot that when grepping. For consistency, we
should probably clean that up.

> I will send a V2 without the fallback.

Cheers!

Mark.
