From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 30 Sep 2014 07:37:41 -0700
Subject: [RFC 3/7] mfd: devicetree: bindings: Add Qualcomm SMD based RPM
 DT binding
In-Reply-To: <85C5C172-D309-41B4-B511-7820BAFDA017@codeaurora.org>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-4-git-send-email-bjorn.andersson@sonymobile.com>
 <85C5C172-D309-41B4-B511-7820BAFDA017@codeaurora.org>
Message-ID: <20140930143740.GK28481@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30 Sep 06:46 PDT 2014, Kumar Gala wrote:

> 
> On Sep 29, 2014, at 7:34 PM, Bjorn Andersson <Bjorn.Andersson@sonymobile.com> wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm-smd.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm-smd.txt
> > new file mode 100644
> > index 0000000..a846101
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm-smd.txt
> > @@ -0,0 +1,122 @@
> > +Qualcomm Resource Power Manager (RPM) over SMD
> > +
> > +This driver is used to interface with the Resource Power Manager (RPM) found in
> > +various Qualcomm platforms. The RPM allows each component in the system to vote
> > +for state of the system resources, such as clocks, regulators and bus
> > +frequencies.
> > +
> > +- compatible:
> > +	Usage: required
> > +	Value type: <string>
> > +	Definition: must be one of:
> > +		    "qcom,rpm-msm8974?
> 
> Why not ?qcom,rpm-smd?.  I?d like to get Jeff H?s input on how
> what we do here for compat and distinguish the A-family RPM support vs
> B-family/RPM-SMD support.
> 

I don't see anything indicating changes in the actual communication, but as
this also encodes what resources are exposed we have to keep this specific.

I'm not sure what you mean with distinguish the A and B family, they are
completely different and there are no overlap in compatibles or implementation.

The overlap is in how children are communicating with the rpm, but this is an
implementation detail - and noted in that patch as a future improvement.


I forgot to add Jeff, but did send him a separate email asking for his input on
all this.

> > +
> > +- qcom,smd-channels:
> > +	Usage: required
> > +	Value type: <stringlist>
> > +	Definition: Shared Memory Channel used for communication with the RPM
> > +
> 
> This needs more details.
> 

Not sure what more to add here. It should contain the name of the channel used
for communication with the rpm. For all current platforms this would be
"rpm_requests".

> > +- #address-cells:
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition: must be 1
> > +
> > +- #size-cells:
> > +	Usage: required
> > +	Value type: <u32>
> > +	Definition: must be 0
> > +
> > += SUBDEVICES
> 
> As I mentioned for the the RPM binding on a-family, we should split out the
> devices into their own binding specs.
> 

Please actually read https://lkml.org/lkml/2014/3/10/567, it's now the third
time I send you that link. If you don't like it then ask Rob to revise his
statement.

For me it makes sense to consolidate the RPM binding in one document rather
than spreading it out in 10 different documents with some implicit
dependencies.

Regards,
Bjorn
