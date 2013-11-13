From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Nov 2013 09:53:29 +0900
Subject: [PATCH 1/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
In-Reply-To: <17979814.3ftdsWAt7J@avalon>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131112051137.GB28649@verge.net.au>
 <20131112052625.GC28649@verge.net.au> <17979814.3ftdsWAt7J@avalon>
Message-ID: <20131113005329.GA25694@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 02:21:04PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 12 November 2013 14:26:25 Simon Horman wrote:
> > On Tue, Nov 12, 2013 at 02:11:37PM +0900, Simon Horman wrote:
> > > On Sat, Nov 09, 2013 at 01:33:48PM +0100, Laurent Pinchart wrote:
> > > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol has
> > > > been created to group all multiplatform-enabled SH-Mobile SoCs. The
> > > > existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
> > > > been converted yet.
> > > > 
> > > > This arrangement works fine for the arch/ code, but lots of drivers
> > > > needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI depend on
> > > > ARCH_SHMOBILE only. In order to avoid changing them, rename
> > > > ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new boolean
> > > > ARCH_SHMOBILE configuration symbol that is selected by both
> > > > ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.
> > > > 
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > Acked-by: Magnus Damm <damm@opensource.se>
> > > 
> > > Thanks, I have queued this up.
> > 
> > I have dropped this for now as it seems that all of the
> > shmobile defconfigs now need to be updated to use ARCH_SHMOBILE_LEGACY
> > instead of ARCH_SHMOBILE.
> 
> Indeed, I forgot about that.
> 
> > It seems to me that needs to be part of this patch to avoid
> > breaking bisecatability. Any thoughts?
> 
> The only bisection this would break is the defconfig bisection. I'm not sure 
> whether we need to care about that, Would that be a bit issue ? I'll submit a 
> separate patch, please feel free to squash it with this one if you believe it 
> should be.

To be honest I'm unsure.
But I think that I am leaning towards keeping the patches separate.
