From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 11 Jan 2016 11:09:09 +0000
Subject: [PATCH] arm64: Add DT support for Juno r2 board
In-Reply-To: <5683F971.9000300@arm.com>
References: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
 <20151229183521.GL12450@rob-hp-laptop> <5683BE7A.9020404@arm.com>
 <CAL_Jsq+RZk3LnOhGtiXRFmxmA6bTOEdymtF1yN=6q=iRmUr_9Q@mail.gmail.com>
 <5683F971.9000300@arm.com>
Message-ID: <20160111110909.GD13633@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 03:34:09PM +0000, Sudeep Holla wrote:
> 
> 
> On 30/12/15 15:09, Rob Herring wrote:
> >On Wed, Dec 30, 2015 at 5:22 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>Hi Rob,
> >>
> >>Thanks for the review.
> >>
> >>On 29/12/15 18:35, Rob Herring wrote:
> >>>
> >>>On Wed, Dec 23, 2015 at 12:10:11PM +0000, Sudeep Holla wrote:
> >>>>
> >>>>Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
> >>>>Cortex A72 cores.
> >>>
> >>>
> >>>That's a bigger change than I'd expect...
> >>>
> >>
> >>I am not sure if I understood what you meant by that. Do you want me to
> >>elaborate with more details ?
> >
> >No, just my commentary that I'd expect r1 -> r2 to be a board or Si
> >spin rather than a whole new core.
> >
> 
> Ah OK, yes it's new Si and has other minor updates like latest revisions
> of Cortex-A53 and other IPs. I just mentioned only the DT visible
> changes in the commit log.
> 
> >>>>Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >>>>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>>>---
> >>>>   Documentation/devicetree/bindings/arm/arm-boards |   1 +
> >>>>   Documentation/devicetree/bindings/arm/cpus.txt   |   1 +
> >>>
> >>>
> >>>This should probably be a separate patch, but I already have a patch in
> >>>my tree for 4.5 adding arm,cortex-a72. So just drop this hunk.
> >>>
> >>
> >>OK, will post DT binding separately.
> >
> >No need, it is already in my tree.
> >
> 
> Sorry for not being clear earlier. I was referring the "arm,juno-r2"
> compatible addition. I assume you have no objection if it's part of the
> same patch.
> 
> >>>>+       pcie-controller at 40000000 {
> >>>>+               compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi",
> >>>>"pci-host-ecam-generic";
> >>>
> >>>
> >>>Is this common with r1?
> >>>
> >>
> >>AFAIK it is. Liviu can you confirm ?
> >
> >Then perhaps you should move this to a common spot.
> >
> 
> True, will wait for Liviu's response.

AFAIK Juno r2 should have identical PCIe controller to r1. I have not been able to
test it myself but at the same time I have no information on any changes applied to
the IP.

Sudeep, probably worth moving the pcie-controller at 40000000 node in juno-base.dtsi
and disable it by default, then re-enable in juno-r1.dts and juno-r2.dts.

Best regards,
Liviu

> 
> -- 
> Regards,
> Sudeep
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
