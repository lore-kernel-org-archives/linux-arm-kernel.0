From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jul 2011 22:27:40 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <20110725103323.GE9653@n2100.arm.linux.org.uk>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
	<20110714113625.GB20903@e102144-lin.cambridge.arm.com>
	<4E241E60.7040403@st.com>
	<20110718125719.GA7410@e102144-lin.cambridge.arm.com>
	<20110719102317.GC26574@n2100.arm.linux.org.uk>
	<4E2D418D.4000800@st.com>
	<20110725103323.GE9653@n2100.arm.linux.org.uk>
Message-ID: <20110725212740.GA20187@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 11:33:23AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 12:12:29PM +0200, Wolfgang BETZ wrote:
> > C is a typed language for a reason.  Don't destroy it with casts.
> > 
> > So, the _minimum_ that needs to change in this patch is for those casts
> > to go, and cpu_switch_mm() needs to be fixed to take the context ID
> > value, rather a context ID value casted to a mm_struct.
> > 
> > Well, this is exactly what the patch is doing right now.
> > I have intentionally avoided to centralize this cast into cpu_switch_mm() in order to be sure to not miss any call to it, accidentally. As said above, the compiler will warn about something like this.
> > Maybe you could take a closer look at v3 of the patch, which I will send out within today.
> 
> You've completely missed my point.  What's the really scary thing here
> is that you can't see that you're doing something very very wrong.

I'd still like to know why we can't avoid piggybacking on the switch_mm code
by doing similar to the hack I posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/058436.html

Given that future cores (>= A15) put the ASID in a different register and
there's apparently a need for a thread switch notifier anyway, tying the
contextidr up so tightly with switch_mm doesn't feel right to me.

So, ugly casts aside, I'm not convinced by the approach taken here.

Will
