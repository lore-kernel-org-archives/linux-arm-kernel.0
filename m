From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 18 Oct 2012 17:47:31 +0200
Subject: [PATCH v2 1/5] ARM: bcm476x: Add platform infrastructure
In-Reply-To: <201210181348.02110.arnd@arndb.de>
References: <20121014221450.866288977@gmail.com>
 <20121014223023.611069832@gmail.com>
 <201210181348.02110.arnd@arndb.de>
Message-ID: <20121018154731.GA9344@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 01:48:01PM +0000, Arnd Bergmann wrote:
> On Sunday 14 October 2012, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > Platform infrastructure for the Broadcom BCM476x ARMv6 SoCs.
> 
> Hi Domenico,

Hi Arnd,

> All your patches look good to me now, except for one thing throughout
> the bindings:
> 
> > Index: b/Documentation/devicetree/bindings/arm/bcm476x.txt
> > ===================================================================
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/bcm476x.txt
> > @@ -0,0 +1,15 @@
> > +Broadcom BCM4760 and BCM4761 SoCs device tree bindings
> > +------------------------------------------------------
> > +
> > +Boards with the BCM4760 SoC shall have the following properties:
> > +
> > +Required root node property:
> > +
> > +compatible = "brcm,bcm4760";
> > +
> > +
> > +Boards with the BCM4761 SoC shall have the following properties:
> > +
> > +Required root node property:
> > +
> > +compatible = "brcm,bcm4761";
> 
> I probably wasn't clear enough with my request to have specific
> chip identifiers in the device tree "compatible" nodes. The idea
> generally is that for completely identical hardware blocks, you
> just need to put the first known variant into the driver, e.g.
> "brcm,bcm4760-system-timer", and in case of a later chip that
> is compatible with it, you list both "brcm,bcm4760-system-timer"
> and "brcm,bcm4761-system-timer" in the compatible property of the
> device tree. The way you did it is also correct and works, but
> is a bit less common.
> 
> How do you want to merge your patches? The preferred way from
> our side is to get a pull request from you sent to arm at kernel.org
> with Cc to the linux-arm-kernel mailing list, but we can also
> pick up the patches separately if necessary.

so the above becomes:

Index: b/Documentation/devicetree/bindings/arm/bcm476x.txt
===================================================================
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm476x.txt
@@ -0,0 +1,15 @@
+Broadcom BCM4760 and BCM4761 SoCs device tree bindings
+------------------------------------------------------
+
+Boards with the BCM4760 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "brcm,bcm4760";
+
+
+Boards with the BCM4761 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "brcm,bcm4760", "brcm,bcm4761";

and the dt_mach in the board file is left only with "brcm,bcm4760" until
required otherwise. The same applies to drivers.

Does the order matter? 

> For the patches that go into different directories like the clk
> and the clocksource drivers, please Cc the respective subsystem
> maintainers and ask them for an Ack. It certainly makes sense
> for a new platform port to get merged through the arm-soc tree,
> but any future improvements should normally just go through the
> subsystem trees.

I'd prefer patches but only because I've not any public git repository. If
the git pull is much more preferred, I surely can manage it.

Thanks,
Domenico
