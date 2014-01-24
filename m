From: agross@codeaurora.org (Andy Gross)
Date: Fri, 24 Jan 2014 01:18:41 -0600
Subject: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
In-Reply-To: <20140121024007.GE13785@codeaurora.org>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389999819-10648-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
 <20140121024007.GE13785@codeaurora.org>
Message-ID: <20140124071841.GA6113@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 06:40:07PM -0800, Stephen Boyd wrote:
> On 01/20, Rob Herring wrote:
> > On Fri, Jan 17, 2014 at 5:03 PM, Bjorn Andersson
> > <bjorn.andersson@sonymobile.com> wrote:
> > 
> > >  .../devicetree/bindings/i2c/qcom,i2c-qup.txt       | 41 ++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
> > > new file mode 100644
> > > index 0000000..a99711b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.txt
> > > @@ -0,0 +1,41 @@
> > > +Qualcomm Universal Peripheral (QUP) I2C controller
> > > +
> > > +Required properties:
> > > + - compatible: Should be "qcom,i2c-qup".
> > 
> > Seems a bit generic. All versions of the IP are exactly the same?
> > "qcom,<chip>-i2c-qup" would be better.
> > 
> 
> There are different versions of the IP in different SoCs. The
> versions for platforms supported upstream are:
> 
> 	1.1.1 (MSM8660, MSM8960)
> 	2.2.1 (MSM8974v2)
> 
> so how about one of "qcom,i2c-qup-v1.1.1" or
> "qcom,i2c-qup-v2.2.1" should be specified as more specific
> compatible strings in addition to "qcom,i2c-qup"?
> 

This definitely needs two compatible tags.  The v1.1.1 supports the FIFO, block,
and data mover modes.  The v2.2.1 supports FIFO, block, and BAM DMA.

The BAM patches are currently in review and ideally BAM support can be added to
the I2C.  We'll need a way to differentiate so BAM can be used.

Otherwise, the register interfaces are interchangeable except for BAM specific
fields in the registers.


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
