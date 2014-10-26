From: ljkenny@gmail.com (Lee Jones)
Date: Sun, 26 Oct 2014 15:22:46 +0000
Subject: [PATCH] bcm2835: add VideoCore Mailbox to the device tree
In-Reply-To: <544C6204.50607@wwwdotorg.org>
References: <1414156805-30253-1-git-send-email-lkundrak@v3.sk>
 <20141024155321.GF10395@x1> <544C6204.50607@wwwdotorg.org>
Message-ID: <20141026152245.GB11689@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Oct 2014, Stephen Warren wrote:

> On 10/24/2014 09:53 AM, Lee Jones wrote:
> > On Fri, 24 Oct 2014, Lubomir Rintel wrote:
> > 
> >> Follows the generic Mailbox Controller bindings as documented in
> >> Documentation/devicetree/bindings/mailbox/mailbox.txt.
> >>
> >> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> >> Cc: Stephen Warren <swarren@wwwdotorg.org>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: devicetree at vger.kernel.org
> >> Cc: linux-rpi-kernel at lists.infradead.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> ---
> >>  arch/arm/boot/dts/bcm2835.dtsi | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> >> index 3342cb1..bd046a9 100644
> >> --- a/arch/arm/boot/dts/bcm2835.dtsi
> >> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> >> @@ -50,6 +50,13 @@
> >>  			#interrupt-cells = <2>;
> >>  		};
> >>  
> >> +		mailbox: mailbox at 0x7e00b880 {
> > 
> > Remove the 0x.
> > 
> >> +			compatible = "brcm,bcm2835-mbox";
> >> +			reg = <0x7e00b880 0x40>;
> >> +			interrupts = <0 1>;
> > 
> > 2 interrupts one cell right?  No flags?
> 
> The DT binding says 1 IRQ in the list, and the interrupt controller in
> bcm2835.dtsi has 2 cells per IRQ.
> 
> Whether that's all the IRQs the HW has for this HW module, I don't know.

Okay, so guessing <BANK INT> then.  Very well, thanks for answering.
