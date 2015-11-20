From: agross@codeaurora.org (Andy Gross)
Date: Fri, 20 Nov 2015 09:56:16 -0600
Subject: [PATCH 4/4] Documentation: usb: dwc3: qcom: Add TCSR mux usage
In-Reply-To: <877flcemip.fsf@saruman.tx.rr.com>
References: <1448008509-8913-1-git-send-email-agross@codeaurora.org>
 <1448008509-8913-5-git-send-email-agross@codeaurora.org>
 <877flcemip.fsf@saruman.tx.rr.com>
Message-ID: <20151120155616.GC8722@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 09:08:46AM -0600, Felipe Balbi wrote:
> 
> Hi,
> 
> Andy Gross <agross@codeaurora.org> writes:
> > This patch adds documentation for the optional syscon-tcsr property in the
> > Qualcomm DWC3 node.  The syscon-tcsr specifies the register and bit used to
> > configure the TCSR USB phy mux register.
> >
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> > index ca164e7..dfa222d 100644
> > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> > @@ -8,6 +8,10 @@ Required properties:
> >    "core"		Master/Core clock, have to be >= 125 MHz for SS
> >  				operation and >= 60MHz for HS operation
> >  
> > +Optional properties:
> > +- syscon-tcsr	Specifies TCSR handle, register offset, and bit position for
> > +			configuring the phy mux setting.
> 
> oh, it's a PHY mux ? I don't think it should be part of any dwc3-* glue
> layer then. By the time we reach dwc3, the mux should be properly
> configured.
> 
> Kishon, any ideas ?
> 
> -- 
> balbi

The only issue with putting it at the phy layer is that i'd have redundant
syscon entries for each pair of phys, unless i group them somehow in dt.  The
only other issue I can think of is that in the downstream kernels, they do this
before messing with the configuration of the dwc3.  So long as the phys do their
thing before the dwc3 (phys latched before config), we're ok.



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
