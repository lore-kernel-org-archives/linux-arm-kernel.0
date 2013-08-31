From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 31 Aug 2013 11:51:25 -0400
Subject: [PATCH v3 2/2] ARM: kirkwood: Add standby support
In-Reply-To: <20130830231003.GA2398@localhost>
References: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377186547-14284-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130830231003.GA2398@localhost>
Message-ID: <20130831155125.GY19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 08:10:04PM -0300, Ezequiel Garcia wrote:
> On Thu, Aug 22, 2013 at 12:49:07PM -0300, Ezequiel Garcia wrote:
> > Implements standby support for Kirkwood SoC. When the SoC enters
> > standby state the memory PM units are disabled, the DDR is set
> > in self-refresh mode, and the CPU is set in WFI.
> > 
> > At this point there's no clock gating, as that is considered each
> > driver's task.
> > 
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-kirkwood/Makefile                   |  2 +
> >  arch/arm/mach-kirkwood/board-dt.c                 |  1 +
> >  arch/arm/mach-kirkwood/common.c                   |  1 +
> >  arch/arm/mach-kirkwood/common.h                   |  6 ++
> >  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
> >  arch/arm/mach-kirkwood/pm.c                       | 73 +++++++++++++++++++++++
> >  6 files changed, 85 insertions(+)
> >  create mode 100644 arch/arm/mach-kirkwood/pm.c
> 
> Any comments on this?

Well, I was sitting on this for the next merge window, since it came in
late and honestly, isn't complete.  You stated yourself in the
coverletter that it offered no real power savings.

How about expanding the series to add proper suspend/resume support to
some of the more power hungry drivers (yes, this might re-awaken the
mv643xx_eth mac address issue), and resubmit?

thx,

Jason.
