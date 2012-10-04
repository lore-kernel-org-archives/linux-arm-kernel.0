From: mporter@ti.com (Matt Porter)
Date: Thu, 4 Oct 2012 08:54:55 -0400
Subject: [PATCH v3 2/6] ARM: davinci: da850-dm646x: remove the SRAM_VIRT
 iotable entry
In-Reply-To: <506D78BE.1000607@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <1349276133-26408-3-git-send-email-mporter@ti.com>
 <506D78BE.1000607@ti.com>
Message-ID: <20121004125455.GE11149@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 05:23:34PM +0530, Sekhar Nori wrote:
> On 10/3/2012 8:25 PM, Matt Porter wrote:
> > From: Ben Gardiner <bengardiner@nanometrics.ca>
> > 
> > The sram regions defined for da850-dm646x in their iotable entries are also
> > defined in their davinci_soc_info's.
> > 
> > Remove this duplicate information which is now uneccessary since sram
> > init will ioremap the regions defined by their davinci_soc_info's.
> > 
> > Since this removal completely removes all uses of SRAM_VIRT, also remove
> > the SRAM_VIRT definition.
> > 
> > Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> > Tested-by: Matt Porter <mporter@ti.com>
> 
> What testing was done with this patch? Can you please add that
> information to the commit text as well.

I have only tested on AM180x with uio_pruss and davinci-pcm (series
for that posted a short while ago). In the uio_pruss case, I run the
sample applications from the userspace PRU package that test
communication with the shared SRAM, DDR, and internal PRU SRAM. For
davinci-pcm, my series enables shared SRAM ping-pong buffering which is
working comparably to pcm capture/playback without ping-pong buffering
enabled on AM180x.

I have not tested PM at all...yet.

I'll add this detail to the commit.

-Matt
