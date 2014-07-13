From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 13 Jul 2014 15:00:38 +0200
Subject: [GIT PULL v2 FOR v3.17] Renesas CMT,
 MTU2 and TMU timers DT support
In-Reply-To: <20140713095457.GA21209@verge.net.au>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <4780671.lrfQIxTHV3@avalon> <20140713095457.GA21209@verge.net.au>
Message-ID: <1929656.0uZaK89oG1@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon and Daniel,

On Sunday 13 July 2014 11:55:01 Simon Horman wrote:
> [Cc Olof Johansson, ARM SoC Team]
> 
> On Wed, Jul 09, 2014 at 11:59:16AM +0200, Laurent Pinchart wrote:
> > On Friday 04 July 2014 15:53:32 Laurent Pinchart wrote:
> > > Hi Daniel,
> > > 
> > > Could you please pull the following changes and drop the first version
> > > of this pull request ? I've fixed one last typo noticed by Simon in
> > > patch 09/19.
> > > 
> > > As last time I have board and SoC changes that depend on the driver
> > > changes and that will need to go through Simon's tree. Could you thus
> > > please provide a stable branch based on one of the v3.16-rc tags ?
> > 
> > Given that I'd like to get the arch/ part of the change set in v3.17,
> > could I ask you to fast track this pull request if possible ?
> 
> Hi Laurent, Hi Daniel,
> 
> I am wondering what the status of this pull request is.  It would be nice
> to get the arch/ changes into v3.17 but we are getting closer to v3.16-rc6
> and I need to have things queued up before then.
> 
> I have also CCed Olof and the ARM SoC team (via arm at kernel.org) as
> if Daniel does provide a stable branch that includes this pull request and
> I use it as the basis for a branch with the arch changes then the
> ARM SoC people would like to know about it before I send a pull request
> for the arch/ changes.

>From my point of view everything is ready for v3.17. Daniel, if you haven't 
been abducted by aliens, could you please process the pull request ? If you 
have, let us know what we can do to help negotiate your release.

> > > The following changes since commit 
4c834452aad01531db949414f94f817a86348d59:
> > >   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)
> > > 
> > > are available in the git repository at:
> > >   git://linuxtv.org/pinchartl/fbdev.git timers/upstream/drivers
> > > 
> > > for you to fetch changes up to cca8d0596c4c7acb371ea1bc5eee9b404b30516a:
> > >   clocksource: sh_mtu2: Add DT support (2014-07-04 15:50:29 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > 
> > > Laurent Pinchart (10):
> > >       clocksource: sh_cmt: Drop support for legacy platform data
> > >       clocksource: sh_cmt: Replace global spinlock with a per-device
> > > spinlock
> > >       clocksource: sh_tmu: Drop support for legacy platform data
> > >       clocksource: sh_tmu: Replace global spinlock with a per-device
> > > spinlock
> > >       clocksource: sh_mtu2: Drop support for legacy platform data
> > >       clocksource: sh_mtu2: Replace global spinlock with a per-device
> > > spinlock
> > >       clocksource: shmobile: Remove unused sh_timer_config members
> > >       clocksource: sh_cmt: Add DT support
> > >       clocksource: sh_tmu: Add DT support
> > >       clocksource: sh_mtu2: Add DT support
> > >  
> > >  Documentation/devicetree/bindings/timer/renesas,cmt.txt |  47 +++++
> > >  .../devicetree/bindings/timer/renesas,mtu2.txt          |  39 ++++
> > >  Documentation/devicetree/bindings/timer/renesas,tmu.txt |  39 ++++
> > >  drivers/clocksource/sh_cmt.c                            | 233 +++++----
> > >  drivers/clocksource/sh_mtu2.c                           | 146 ++++-----
> > >  drivers/clocksource/sh_tmu.c                            | 127 +++++----
> > >  include/linux/sh_timer.h                                |   5 -
> > >  7 files changed, 309 insertions(+), 327 deletions(-)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/timer/renesas,tmu.txt

-- 
Regards,

Laurent Pinchart
