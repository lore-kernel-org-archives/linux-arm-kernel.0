From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Dec 2011 09:57:43 +0200
Subject: [PATCH 4/7] amp/omap: add a remoteproc driver
In-Reply-To: <1319536106-25802-5-git-send-email-ohad@wizery.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-5-git-send-email-ohad@wizery.com>
Message-ID: <CAK=WgbZvH3eiouryKDenC_x0LdDcHFuumhfoeY4ueiwT5r0cxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, Oct 25, 2011 at 11:48 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Add a remoteproc driver for OMAP4, so we can boot the dual-M3 "Ducati"
> and DSP subsystems.
>
> Use the omap_device_* API to control the hardware state, and utilize
> the OMAP mailbox to interrupt the remote processor when a new message
> is pending (the mailbox payload is used to tell it which virtqueue was
> the message placed in).
>
> Conversely, when an inbound mailbox message arrives, tell the remoteproc
> core which virtqueue is triggered.
>
> Later we will also use the mailbox payload to signal omap-specific
> events like remote crashes (which will be used to trigger remoteproc
> recovery) and power management transitions. At that point we will also
> extend the remoteproc core to support this.
>
> Based on (but now quite far from) work done by Fernando Guzman Lugo
> <fernando.lugo@ti.com> and Hari Kanigeri <h-kanigeri2@ti.com>.
>
> Designed with Brian Swetland <swetland@google.com>.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Brian Swetland <swetland@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> ---
> ?arch/arm/plat-omap/include/plat/remoteproc.h | ? 56 ++++++
> ?drivers/amp/remoteproc/Kconfig ? ? ? ? ? ? ? | ? 21 +++
> ?drivers/amp/remoteproc/Makefile ? ? ? ? ? ? ?| ? ?4 +-
> ?drivers/amp/remoteproc/omap_remoteproc.c ? ? | ?248 ++++++++++++++++++++++++++
> ?drivers/amp/remoteproc/omap_remoteproc.h ? ? | ? 69 +++++++
> ?5 files changed, 397 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
> ?create mode 100644 drivers/amp/remoteproc/omap_remoteproc.c
> ?create mode 100644 drivers/amp/remoteproc/omap_remoteproc.h

I'm about to add this to linux-next (minus the 'amp' wording); can I
please have your Acked-by for this (at least for the plat-omap change) ?

Thanks,
Ohad.
