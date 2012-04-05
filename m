From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 5 Apr 2012 09:47:11 -0700
Subject: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
In-Reply-To: <20120405132617.76e04217@bob.linux.org.uk>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUd+_coW7ebuN_o=yZbbSVKnkx5R6=yHjUEUc0EcQGtgSRQ@mail.gmail.com>
 <20120405132617.76e04217@bob.linux.org.uk>
Message-ID: <20120405164711.GC16688@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 01:26:17PM +0100, Alan Cox wrote:
> On Thu, 5 Apr 2012 16:54:03 +0530
> "Raja, Govindraj" <govindraj.raja@ti.com> wrote:
> 
> > On Wed, Mar 21, 2012 at 3:54 PM, Govindraj.R <govindraj.raja@ti.com>
> > wrote:
> > > From: "Govindraj.R" <govindraj.raja@ti.com>
> > >
> > > Based on Linux-OMAP tree uart branch.
> > > (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> > > remotes/origin/uart)
> > >
> > > * Removes the cpu checks wherever possible and use version reg
> > > ?for populating features and errata's
> > > * enable tx wakeup available in wer reg for applicable
> > > ?module revision's
> > >
> > > Govindraj.R (3):
> > > ?OMAP2+: UART: Remove cpu checks for populating errata flags
> > > ?OMAP2+: UART: enable tx wakeup bit for wer reg
> > > ?OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
> > >
> > > ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 13 +----
> > > ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?8 +++-
> > > ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 71
> > > ++++++++++++++++++++++++- 3 files changed, 78 insertions(+), 14
> > > deletions(-)
> > 
> > Alan / Greg,
> > 
> > With you ack on tty parts can this series be upstreamed from
> > omap tree ?
> 
> Fine by me - this seems primarily to be architectural details.

Fine by me as well:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
