From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 11 Jan 2016 10:47:07 +0000
Subject: [PATCH] arm64/dts: Add missing DMA Abort interrupt to Juno
In-Reply-To: <568E7EF4.1020403@arm.com>
References: <6a66d2ac442925e066fe9b67ee2883de5894b0d3.1452168063.git.robin.murphy@arm.com>
 <2736927.0LiVxGZzgm@wuerfel> <568E7EF4.1020403@arm.com>
Message-ID: <20160111104707.GB13633@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 03:06:28PM +0000, Sudeep Holla wrote:
> 
> 
> On 07/01/16 14:36, Arnd Bergmann wrote:
> >On Thursday 07 January 2016 12:01:59 Robin Murphy wrote:
> >>The DMA-330 has an "irq_abort" interrupt line on which it signals faults
> >>separately from the "irq[n:0]" channel interrupts. On Juno, this is
> >>wired up to SPI 92; add it to the DT so that DMAC faults are correctly
> >>reported for the driver to reset the thing, rather than leaving it
> >>locked up and waiting to time out.
> >>
> >>CC: Liviu Dudau <liviu.dudau@arm.com>
> >>CC: Sudeep Holla <sudeep.holla@arm.com>
> >>CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>
> >
> >Nothing wrong with the patch, but could you please come up with
> >a more structured way to get patches for Juno into the kernel?
> >
> 
> Sorry for that. Liviu is on holidays, he usually reviews Juno DTS change
> and provides ack. But missed to check with him before he disappeared.
> 
> >You have addressed the patch "to:" the arm-soc maintainers, but
> >you are not listed in the maintainers file for the directory, so
> >it's not clear what you expect to happen here.
> >
> >Ideally, we'd get patches from just one of the people listed
> >in the MAINTAINERS file normally, and let us know if the
> >primary maintainer changes, or if one of the others sends a
> >patch because that person is unavailable.
> >
> 
> We(me along with Liviu and Lorenzo) will try to group them together and
> one of us can send you pull request.
> 
> I don't think there's any other fixes on the list though there are few
> feature additions which I assume is too late for v4.5 now. But still I
> prefer to wait till next week so that I can check with Liviu to see if
> there are any other Juno fixes that can be grouped.

Hi all,

The only other changes queued for v4.5 are the HDLCD patches which touch
on the .dts. Arnd, Olof: how do you prefer to handle this? Can you take
Robin's patch in arm-soc and I'll queue the rest of the changes via David
Airlie?

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
