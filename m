From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 24 Sep 2014 10:09:09 -0700
Subject: [PATCH 1/2] ARM: zynq: DT: Add missing reference for ADC
In-Reply-To: <f6b47676-f664-4b01-8c70-a526eb8d1931@BY2FFO11FD011.protection.gbl>
References: <fced9e56dc4ef8df9ead34f6444c010cc31c7a61.1411567289.git.michal.simek@xilinx.com>
 <20140924161814.GG13679@xsjandreislx>
 <f6b47676-f664-4b01-8c70-a526eb8d1931@BY2FFO11FD011.protection.gbl>
Message-ID: <6c7fde5f-aff1-41c1-8cde-b01b976aa9f3@BY2FFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-24 at 07:06PM +0200, Michal Simek wrote:
> On 09/24/2014 06:18 PM, S?ren Brinkmann wrote:
> > On Wed, 2014-09-24 at 04:01PM +0200, Michal Simek wrote:
> >> Add missing reference for ADC node.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >>  arch/arm/boot/dts/zynq-7000.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> >> index 772381fe07bb..fc90f47f9c03 100644
> >> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> >> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> >> @@ -64,7 +64,7 @@
> >>  		interrupt-parent = <&intc>;
> >>  		ranges;
> >>
> >> -		adc at f8007100 {
> >> +		adc: adc at f8007100 {
> > I think we enumerated all labels. I.e. 'adc0' is probably better.
> 
> I was thinking about it and the reason I didn't use that adc0 was
> that it is unique and it is just one in PS. Maybe there could be another adc in PL
> but it will be probably automated not to use adc key world.
> For PL part names was depending on user description.
> 
> Anyway logic was not to use enumerated label for unique IPs.
As you said yourself, due to having/being an FPGA and also the
extensibility of the platform via buses (including PCIe), I
would not consider any IP to be unique.

	S?ren
