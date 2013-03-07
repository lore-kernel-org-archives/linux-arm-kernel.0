From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Mar 2013 03:32:21 +0000
Subject: ARM: 7653/2: do not scale loops_per_jiffy when using a constant
 delay clock
In-Reply-To: <20130306183751.GV17833@n2100.arm.linux.org.uk>
References: <20130306022308.GA21539@mudshark.cambridge.arm.com>
 <20130306183751.GV17833@n2100.arm.linux.org.uk>
Message-ID: <20130307033221.GC25137@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Wed, Mar 06, 2013 at 06:37:51PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 06, 2013 at 02:23:08AM +0000, Will Deacon wrote:
> > I notice that commit 70264367a243 ("ARM: 7653/2: do not scale loops_per_jiffy
> > when using a constant delay clock") is in mainline, but I'm not sure whether
> > it's the right fix. Unfortunately, I failed to find it in the list archives,
> > so I couldn't repy to the original patch.
> 
> Sigh.  Here we go again.  I've said this many times.  Patches need to be
> sent to the mailing list *before* they're sent to the patch system.  Not
> just the complex ones.  ALL PATCHES including those which look like simple
> fixes.
> 
> The reason being is that if someone wants to comment on the patch, they
> can.  For exactly the kind of reason that Will brings up above.  You may
> think your fix is obvious and the right solution, but someone else in this
> complex ecosystem may have a case where your otherwise perfect solution
> doesn't work.

I've just spoken to Nico in person about this, so it's probably worthwhile
mentioning something here in an attempt to clear things up.

It turns out that the problem which the patch in question tries to solve was
originally fixed by somebody in ARM and discussed off-list (which explains
the acks on the final patch). However, this got stuck in code review for a
disproportionally large amount of time, until Nico admittedly lost his rag;
writing his own patch and putting it straight into the patch system.

Of course, this still isn't the right way to get patches into mainline and
the points Russell makes above are completely correct. I wonder if we could
extend the patch system to reject patches automatically if they don't appear
in the linux-arm-kernel archives?

On the topic of this patch: I still think that we should revert it and
require cpufreq drivers to pass CPUFREQ_CONST_LOOPS in their flags (I guess
the cpu0 platform data may need extending to take some flags). Longer
term, we might want to assess the binding between timer-based delays and
loops_per_jiffy, but that's an entirely new problem.

Will
