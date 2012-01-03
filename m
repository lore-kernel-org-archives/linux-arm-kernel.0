From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 17:21:59 +0000
Subject: Is Pandaboard cpuhotplug working stably?
In-Reply-To: <4EF94E5C.5040608@nvidia.com>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk>
 <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
 <20111221100706.GC3354@n2100.arm.linux.org.uk>
 <CAMQu2gy8mwJ-aKit0b4d7=4FkxeFakfnL-phy0eMOK81Oe=PCw@mail.gmail.com>
 <20111222102454.GD3354@n2100.arm.linux.org.uk> <4EF94E5C.5040608@nvidia.com>
Message-ID: <20120103172159.GB2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 10:19:32AM +0530, Varun Wadekar wrote:
> >>
> >> [1] https://lkml.org/lkml/2011/6/20/79
> >> [2] https://lkml.org/lkml/2011/12/15/255
> > [1] is already fixed - and is not the latest "problem" with this code.
> > Fixing the problem in [1] actually itself created the latest problem
> > with smp_call_function() which wasn't there before this change.  Patch
> > [2] refers to this problem and proposes a fix for it.
> 
> Any idea if this patch if good to go in mainline? I am facing the same
> issue on Tegra with 3.1.5 and this patch fixes the issue caused by [1].

Either we deem the fix for [1] to have caused a worse problem than it
fixed and we back it out, or the patch in [2] gets merged.

Which happens depends on the scheduler people; it can only be solved by
solving the nigh-on impossible-to-satisfy demands of the scheduler code
upon the CPU hotplug code.

I would suggest that [2] is a rather important patch which needs to be
merged before -final.
