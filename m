From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 06 Apr 2011 17:36:07 +0100
Subject: For SMP, Is platform specific secondary startup functionreally
	needed?
In-Reply-To: <a192437f-15b5-4783-b039-6f1128f5c730@VA3EHSMHS014.ehs.local>
References: <7b2e9aed-1162-43f3-8c33-59b43b0a1964@VA3EHSMHS036.ehs.local>
	<1302100751.28846.6.camel@e102109-lin.cambridge.arm.com>
	<a192437f-15b5-4783-b039-6f1128f5c730@VA3EHSMHS014.ehs.local>
Message-ID: <1302107767.28846.105.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-06 at 15:42 +0100, John Linn wrote:
> > On Wed, 2011-04-06 at 14:48 +0100, John Linn wrote:
> > > I'm doing some cleanup of SMP patches based on Russell and Catalin's
> > > input which was real helpful. It seems to me that there is not always a
> > > need for a platform specific secondary startup.
> > >
> > > I have tested with just letting CPU1 go straight to secondary_startup()
> > > in head.S and it works fine.
> > >
> > > I'm probably missing something obvious, if so can you share it?
> >
> > We use the pen release mechanism serialise the secondary CPUs booting.
> 
> I'm not saying you can't have it, just that some platforms may not need
> it.
> 
> Maybe I'm oversimplifying the boot process for our platform, but it
> seems to be working fine.

I haven't looked at your code in detail. Does this platform only have
two cores? If that's the case, you should be fine.

But if you have more than one core and you don't serialise the entry to
secondary_startup(), the __cpu_up() function may get confused.

-- 
Catalin
