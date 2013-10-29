From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 29 Oct 2013 10:12:38 -0500
Subject: [PATCH v3 06/10] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <1383055709.2837.17.camel@iivanov-dev.int.mm-sol.com>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <043d714725f8b6df1873047164d2d0e78778138b.1382985169.git.joshc@codeaurora.org>
 <1383055709.2837.17.camel@iivanov-dev.int.mm-sol.com>
Message-ID: <20131029151238.GF20207@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 04:08:29PM +0200, Ivan T. Ivanov wrote:
> On Mon, 2013-10-28 at 13:12 -0500, Josh Cartwright wrote: 
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > ---
> >  .../bindings/spmi/qcom,spmi-pmic-arb.txt           | 42 ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> > new file mode 100644
> > index 0000000..68949aa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> > @@ -0,0 +1,42 @@
> > +Qualcomm SPMI Controller (PMIC Arbiter)
> > +
> > +The SPMI PMIC Arbiter is found on the Snapdragon 800 Series.  It is an SPMI
> > +controller with wrapping arbitration logic to allow for multiple on-chip
> > +devices to control a single SPMI master.
> > +
> > +The PMIC Arbiter can also act as an interrupt controller, providing interrupts
> > +to slave devices.
> > +
> > +See spmi.txt for the generic SPMI controller binding requirements for child
> > +nodes.
> > +
> > +Required properties:
> > +- compatible : should be "qcom,spmi-pmic-arb".
> > +- reg-names  : should be "core", "intr", "cnfg"
> > +- reg : offset and length of the PMIC Arbiter Core register map.
> > +- reg : offset and length of the PMIC Arbiter Interrupt controller register map.
> > +- reg : offset and length of the PMIC Arbiter Configuration register map.
> > +- #address-cells : must be set to 1
> 
> This doesn't seem to follow generic set of bindings for the SPMI
> controllers. #address-cells : must be set to 2.

Indeed, good catch.  I'll fix it up.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
