From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 5 Dec 2014 22:17:58 +0530
Subject: [PATCH RESEND] Documentation: devicetree: Fix Xilinx VDMA
 specification
In-Reply-To: <bd47278216b64375b32cdc9ed66fe907@BN1BFFO11FD024.protection.gbl>
References: <1415800277-6817-1-git-send-email-afaerber@suse.de>
 <6067bede14b9421fa87db96bdc66dc66@BN1AFFO11FD040.protection.gbl>
 <5463A0F4.6060300@suse.de>
 <bd47278216b64375b32cdc9ed66fe907@BN1BFFO11FD024.protection.gbl>
Message-ID: <20141205164758.GR3411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 10:26:03AM -0800, S?ren Brinkmann wrote:
> On Wed, 2014-11-12 at 07:03PM +0100, Andreas F?rber wrote:
> > Am 12.11.2014 um 16:57 schrieb S?ren Brinkmann:
> > > On Wed, 2014-11-12 at 02:51PM +0100, Andreas F?rber wrote:
> > >> The specification requires xlnx,data-width, but example and driver use
> > >> xlnx,datawidth. Change the specification to match the implementation.
> > > 
> > > Isn't this the wrong way around? The bindings are considered API, so
> > > shouldn't the driver be fixed to match the spec?
> > 
> > In theory, patch review should've never let the two differ... ;)
> > 
> > It's not my driver, so I fixed the perceived inconsistency the least
> > invasive way; Michal and Srikanth seemed to concur at the time.
> > 
> > https://patchwork.kernel.org/patch/4620261/
> > 
> > > Are there already dts files out there using either of these options?
> > 
> > In upstream, no. microblaze and virtex440 use a
> > xlnx,include-datawidth-matching-0 property as precedence for the
> > spelling, whereas there is an fsl,data-width and an unused msix-data-width.
> > 
> > Downstream, yes: Beyond my own patch derived from the Parallella tree,
> > there's some in the ADI tree. None in the Xilinx tree on quick check.
> > 
> > I haven't encountered any using the documented xlnx,data-width - but
> > this patch was authored pre 3.17, haven't ran a full Web search again.
> 
> grepping through linux-next shows some usage of xlnx,datawidth, but
> only the single hit in  Documentation for xlnx,data-width.
> Other than VDMA the other hit seems to be just some DT
> documentation which I can't find a driver for...
> Anyhow, this patch is probably the best way of fixing this.
the driver had issues so want applied, I havent seen repot though. 
Will apply this now

-- 
~Vinod

> 
> Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> 	Thanks,
> 	S?ren

-- 
