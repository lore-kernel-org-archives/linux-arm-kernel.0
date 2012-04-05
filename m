From: alan@linux.intel.com (Alan Cox)
Date: Thu, 5 Apr 2012 13:26:17 +0100
Subject: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
In-Reply-To: <CAMrsUd+_coW7ebuN_o=yZbbSVKnkx5R6=yHjUEUc0EcQGtgSRQ@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUd+_coW7ebuN_o=yZbbSVKnkx5R6=yHjUEUc0EcQGtgSRQ@mail.gmail.com>
Message-ID: <20120405132617.76e04217@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Apr 2012 16:54:03 +0530
"Raja, Govindraj" <govindraj.raja@ti.com> wrote:

> On Wed, Mar 21, 2012 at 3:54 PM, Govindraj.R <govindraj.raja@ti.com>
> wrote:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> >
> > Based on Linux-OMAP tree uart branch.
> > (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> > remotes/origin/uart)
> >
> > * Removes the cpu checks wherever possible and use version reg
> > ?for populating features and errata's
> > * enable tx wakeup available in wer reg for applicable
> > ?module revision's
> >
> > Govindraj.R (3):
> > ?OMAP2+: UART: Remove cpu checks for populating errata flags
> > ?OMAP2+: UART: enable tx wakeup bit for wer reg
> > ?OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
> >
> > ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 13 +----
> > ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?8 +++-
> > ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 71
> > ++++++++++++++++++++++++- 3 files changed, 78 insertions(+), 14
> > deletions(-)
> 
> Alan / Greg,
> 
> With you ack on tty parts can this series be upstreamed from
> omap tree ?

Fine by me - this seems primarily to be architectural details.
