From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 18 Feb 2011 09:06:25 +0000
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <2fdc2d92-486e-4319-866f-3882938363c3@VA3EHSMHS026.ehs.local>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>
	<1297872716-13353-2-git-send-email-john.linn@xilinx.com>
	<1297872716-13353-3-git-send-email-john.linn@xilinx.com>
	<e58673f5-2881-4820-b5cd-99e8ef294ed5@VA3EHSMHS024.ehs.local>
	<20110217100126.GD22961@pulham.picochip.com>
	<2fdc2d92-486e-4319-866f-3882938363c3@VA3EHSMHS026.ehs.local>
Message-ID: <20110218090625.GA3203@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 06:19:09PM -0700, John Linn wrote:
> > > +#define PHYS_OFFSET             0x0
> > 
> > This should be PLAT_PHYS_OFFSET and could do with being surrounded
> with
> > UL() e.g.
> > 
> > #define PLAT_PHYS_OFFSET	UL(0x00000000)
> 
> This doesn't build with 2.6.38-rc5, am I missing something?
> 
> PHYS_OFFSET is still needed from what I can tell, but maybe I overlooked
> something.

The change is queued up in Russell's devel branch for the dynamic p2v 
and will be in 2.6.39.  For a patch series like this it's probably worth 
developing off of linux-next[1].  This contains all of the trees that 
will be mereged into the next kernel so carries the bigger changes like 
dynamic p2v.

Jamie

1. git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
