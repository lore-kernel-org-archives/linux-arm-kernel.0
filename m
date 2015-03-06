From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 6 Mar 2015 19:23:45 +0100
Subject: [PATCH] pinctrl: dt: at91: new binding
In-Reply-To: <AB034DC5-9E4C-4883-BBF0-B93B438C7A54@jcrosoft.com>
References: <1424943294-8805-1-git-send-email-plagnioj@jcrosoft.com>
 <54F9C2FE.8060804@atmel.com>
 <AB034DC5-9E4C-4883-BBF0-B93B438C7A54@jcrosoft.com>
Message-ID: <20150306192345.1262cc94@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Sat, 7 Mar 2015 00:49:55 +0800
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> 
> > On Mar 6, 2015, at 11:08 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > 
> > Le 26/02/2015 10:34, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> >> Today if we want to disable a pio bank we may will siliently break pinctrl
> >> configuration in the DT. This will be detected only at runtime.
> >> 
> >> So move the pinctrl configuration to the bank instead of the bus.
> >> This allow to detect pinctrl issue at DT compiling time when disable a bank.
> >> 
> >> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: devicetree at vger.kernel.org
> >> ---
> >> .../bindings/pinctrl/atmel,at91-pinctrl.txt        | 66 ++++++++++++++++++++++
> >> 1 file changed, 66 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> >> index b7a93e8..78355ee 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> >> @@ -148,3 +148,69 @@ dbgu: serial at fffff200 {
> >> 	pinctrl-0 = <&pinctrl_dbgu>;
> >> 	status = "disabled";
> >> };
> >> +
> >> +II) New Bindings per PIO Block
> > 
> > Sorry but NACK.
> > 
> > I don't want to manage another flavor of the pinmux biding with no real
> > benefit. I would have been good if we had it from day-1. Now it's too late.
> 
> yes we do, we catch but a compiling time instead of RUNTIME which is critical
> 
> so I?ll pass on the NACK

Tell me, how can you pass on a NACK coming from the at91 maintainer
(which is also your co-maintainer) when you modify bindings of an at91
driver ?
Please let's try to be constructive here, so that we can find an
acceptable solution.

> 
> > 
> > Moreover, splitting a binding definition if you have a function given by
> > multiple banks can be weird and not well understood in regard to our
> > current group+function definition scheme (Cf. your last example).
> > 

I don't think it's a good idea either: you'll have to split pinconf
definitions and that definitely doesn't improve readability.

> 
> Others already do so and this is not complex at all

Could you point out these bindings (and real examples please).

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
