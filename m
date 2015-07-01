From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jul 2015 15:53:54 +0100
Subject: Oops at boot after commit 965278dcb8ab... when using split
 memory region
In-Reply-To: <20150701144612.GG2310@leverpostej>
References: <CAGGh5h061qpus=RK-iDyzbc9xG+dJXy8AosuN=aryEVZCPPhtw@mail.gmail.com>
 <20150701144612.GG2310@leverpostej>
Message-ID: <20150701145354.GL7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 03:46:12PM +0100, Mark Rutland wrote:
> On Wed, Jul 01, 2015 at 03:15:33PM +0100, jean-philippe francois wrote:
> > Hi,
> 
> Hi,
> 
> > commit 965278dcb8ab0b1f666cc47937933c4be4aea48d, (ARM: 8356/1: mm:
> > handle non-pmd-aligned end of RAM) causes my dm3730 based board to
> > oops at boot when using a split memory description.
> > The kernel command line parameter is :
> > mem=55M at 0x80000000 mem=128M at 0x88000000
> > 
> > If the same board is booted without the mem argument, it boots to userspace.
> 
> Thanks for the report.
> 
> Javier reported a similar issue [1], which was somehow fixed by Laura's
> patch to update the memblock limit [2,3].
> 
> I don't yet understand why, but if that works for you it would be an
> interesting data point.
> 
> > Below is the bootlog.
> 
> Interesting. That blows up a lot later than I'd expect. I'll see if I
> can reproduce the issue locally.

Yes, I think we need to understand what's going on here, and what's
causing these failures, rather than blindly applying a patch which
seems to solve the problem.

I'm not bothering investigating right now as it is far too hot and
humid to concentrate today.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
