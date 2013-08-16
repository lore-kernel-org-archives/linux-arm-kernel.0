From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 16 Aug 2013 14:25:49 -0500
Subject: [PATCH RFC 3/3] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <D1534646-7CB5-4EE7-8C1E-1C607BE22396@codeaurora.org>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <b639088d50df93caaef8fe7e09c12953b1153ce8.1376596224.git.joshc@codeaurora.org>
 <D1534646-7CB5-4EE7-8C1E-1C607BE22396@codeaurora.org>
Message-ID: <20130816192549.GG4035@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Kumar-

Thanks for the review.

On Fri, Aug 16, 2013 at 01:53:27PM -0500, Kumar Gala wrote:
> On Aug 9, 2013, at 3:37 PM, Josh Cartwright wrote:
> 
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > ---
> > .../devicetree/bindings/spmi/spmi-pmic-arb.txt     | 26 ++++++++++++++++++++++
> > 1 file changed, 26 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/spmi/spmi-pmic-arb.txt
> 
> As this is a qcom specific binding, I think the file name should be msm-spmi-pmic-arb.txt or something like that.

Agreed.  It might be nice to use a vendor prefix in the name too.  How's qcom,msm-pmic-arb.txt sound?

> > diff --git a/Documentation/devicetree/bindings/spmi/spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/spmi-pmic-arb.txt
> > new file mode 100644
> > index 0000000..1c14bf4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spmi/spmi-pmic-arb.txt
> > @@ -0,0 +1,26 @@
> > +Qualcomm SPMI Controller (PMIC Arbiter)
> 
> We should get in the habit of trying to have at least one sentence about what the device is or does.

Certainly.

> > +
> > +Required properties:
> > +- compatible : should be "qcom,spmi-pmic-arb".
> > +- reg-names  : should be "core", "intr", "cnfg"
> > +- reg : offset and length of the PMIC Arbiter Core register map.
> > +- reg : offset and length of the PMIC Arbiter Interrupt controller register map.
> > +- reg : offset and length of the PMIC Arbiter Configuration register map.
> > +- #address-cells : must be set to 1
> > +- #size-cells : must be set to 0
> 
> Hmm, you aren't describe anything about child nodes.

Indeed.  I'll put together a generic SPMI binding document as you had
suggested before and reference it in this binding.

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
