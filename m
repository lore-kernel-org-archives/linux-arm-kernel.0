From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Feb 2014 17:36:47 +0000
Subject: [Patch v6 1/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <20140221163053.GA3102@qualcomm.com>
References: <1392964986-5207-1-git-send-email-agross@codeaurora.org>
 <1392964986-5207-2-git-send-email-agross@codeaurora.org>
 <20140221092657.GD7541@e106331-lin.cambridge.arm.com>
 <20140221163053.GA3102@qualcomm.com>
Message-ID: <20140221173647.GC28555@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 04:30:53PM +0000, Andy Gross wrote:
> On Fri, Feb 21, 2014 at 09:26:57AM +0000, Mark Rutland wrote:
> > On Fri, Feb 21, 2014 at 06:43:04AM +0000, Andy Gross wrote:
> > > Add device tree binding support for the QCOM BAM DMA driver.
> > > 
> [snip]
> > > +Required properties:
> > > +- compatible:	Must be "qcom,bam-v1.4.0" for MSM8974 V1
> > > +		Must be "qcom,bam-v1.4.1" for MSM8974 V2
> > 
> > This looks a bit odd. How about:
> > 
> > - compatible: must contain:
> >   * "qcom,bam-v1.4.0" for MSM8974 V1
> >   * "qcom,bam-v1.4.1" for MSM8974 V2
> > 
> 
> Agreed.  I'll fix that.
> 
> > > +- reg: Address range for DMA registers
> > > +- interrupts: single interrupt for this controller
> > 
> > This device only has a single interrupt? Or there's only one we care
> > about at the moment?
> > 
> 
> Yes only a single interrupt.  I can remove the s.

Please don't, the interrupts proeprty is standard and shouldn't change.

I was only asking to ensure that all interrupts were described in the
binding, which they are. :)

> 
> > > +- #dma-cells: must be <1>
> > > +- clocks: required clock
> > > +- clock-names: name of clock
> > 
> > Either describe the _exact_ name this binding expects for any clocks
> > input, or get rid of clock-names. I would prefer the former.
> 
> So then I'd use the full name in the driver file.  That's fine.

Yup. 

> 
> [snip]
> > > +Client:
> > > +Required properties:
> > > +- dmas: List of dma channel requests
> > > +- dma-names: Names of aforementioned requested channels
> > 
> > Do we really need to describe the client binding? Do we not have a
> > generic DMA binding doc we can refer to?
> > 
> 
> Originally there was more information in the entry.  It was pared down over time
> and I didn't go back to referencing the generic doc.  I'll do this and that'll
> fix this and your next comment.

Sounds good!

Cheers,
Mark.
