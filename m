From: mporter@ti.com (Matt Porter)
Date: Wed, 23 Jan 2013 16:37:36 -0500
Subject: [PATCH v5 00/14] DMA Engine support for AM33XX
In-Reply-To: <20130123022133.GA5727@opensource.wolfsonmicro.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <50FEB6B2.5020303@ti.com>
 <20130123022133.GA5727@opensource.wolfsonmicro.com>
Message-ID: <20130123213736.GC5256@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 10:21:42AM +0800, Mark Brown wrote:
> On Tue, Jan 22, 2013 at 09:26:34PM +0530, Sekhar Nori wrote:
> > On 1/16/2013 2:02 AM, Matt Porter wrote:
> 
> > > This series adds DMA Engine support for AM33xx, which uses
> > > an EDMA DMAC. The EDMA DMAC has been previously supported by only
> > > a private API implementation (much like the situation with OMAP
> > > DMA) found on the DaVinci family of SoCs.
> 
> > Will you take this series through the OMAP tree? Only 1/14 touches
> > mach-davinci and I am mostly okay with it except some changes I just
> > requested Matt to make in another thread.
> 
> Is this series somewhere near actually getting merged then? It seemed
> like there was lots of stuff going on.

The issues raised by Sekhar and Santosh were reasonably minor and will
be addressed. My major concern is that the dependency on some api to
fetch dmaengine driver SG limitations is not resolved. That's being
discussed in https://lkml.org/lkml/2013/1/10/432

If I don't get confirmation from Vinod soon, I'll just take a stab at
implementing the callbacks he mentioned in that thread. Static
per-channel caps don't provide the information needed by a client driver
the uses the EDMA DMAC.

Alternatively, we can go back to the hack that looks at the edma
phandle and hardcodes the mmc SG limits to magic values, but that's just
plain ugly. I could live with it temporarily if we can't get the
dmaengine api resolved until 3.10...dunno if others can though. ;)

-Matt
