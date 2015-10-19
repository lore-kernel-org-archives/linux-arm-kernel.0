From: joshc@ni.com (Josh Cartwright)
Date: Mon, 19 Oct 2015 13:24:16 -0500
Subject: [PATCHv2 2/3] ARM: zynq: dt: Updated devicetree for Zynq 7000
 platform.
In-Reply-To: <5624F985.8050905@xilinx.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <1445035350-3569-3-git-send-email-moritz.fischer@ettus.com>
 <20151018175324.GH12756@jcartwri.amer.corp.natinst.com>
 <5624F985.8050905@xilinx.com>
Message-ID: <20151019182416.GL12756@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 04:09:09PM +0200, Michal Simek wrote:
> On 10/18/2015 07:53 PM, Josh Cartwright wrote:
> > On Fri, Oct 16, 2015 at 03:42:29PM -0700, Moritz Fischer wrote:
[..]
> >> @@ -294,6 +294,11 @@
> >>  		devcfg: devcfg at f8007000 {
> >>  			compatible = "xlnx,zynq-devcfg-1.0";
> >>  			reg = <0xf8007000 0x100>;
> >> +			interrupt-parent = <&intc>;
> > 
> > You shouldn't need interrupt-parent here.  In fact, I suspect it can be
> > removed from all sibling nodes as well.
> 
> Correct. But I tend to do it vice-versa. To remove it from amba node and
> keep it in every IP here. The reason is simple to let everybody know
> that setting up right interrupt controller is something what they have
> to care. If you have more interrupt controllers in the system it can be
> messy.

If you like that, then you'd like the interrupt-extended properly even
better (I think).

> But again. Please remove this patch from this series. This will go to
> mainline through arm-soc but 1/3 and 3/3 will go through Greg. That's
> why please do not include it here.

Not all of the patches in a series need to go through the same
maintainer...splitting them up is common.  It's nice seeing related
things out on the list together.  (Especially when there is a dependency
at some level).

  Josh
