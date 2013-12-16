From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Dec 2013 17:48:29 -0600
Subject: [PATCH v3 0/2] usb: fix controller-PHY binding for OMAP3 platform
In-Reply-To: <20131216223826.GG26293@atomide.com>
References: <1387209225-11520-1-git-send-email-kishon@ti.com>
 <20131216212918.GH12896@saruman.home>
 <20131216223826.GG26293@atomide.com>
Message-ID: <20131216234829.GC29284@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 16, 2013 at 02:38:27PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [131216 13:31]:
> > Hi,
> > 
> > On Mon, Dec 16, 2013 at 09:23:43PM +0530, Kishon Vijay Abraham I wrote:
> > > After the platform devices are created using PLATFORM_DEVID_AUTO, the
> > > device names given in usb_bind_phy (in board file) does not match with
> > > the actual device name causing the USB PHY library not to return the
> > > PHY reference when the MUSB controller request for the PHY in the non-dt boot
> > > case.
> > > So removed creating platform devices using PLATFORM_DEVID_AUTO in omap2430.c.
> > > 
> > > Did enumeration testing in omap3 beagle.
> > > 
> > > Changes from v2:
> > > * Fixed the commit log
> > > 
> > > Changes from v1:
> > > * refreshed to the latested mainline kernel
> > > * added musb_put_id from omap2430 remove.
> > 
> > Tony, how do you want to handle this ? You want me to provide you a
> > branch which we both merge ?
> 
> Yes that would be great thanks. For the mach-omap2 touching parts:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Here it is, let me know if you prefer a signed tag:

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git usb-phy-binding-omap3

for you to fetch changes up to 23ada3130cf4e56acb86fdff4c26113188d52d18:

  arm: omap: remove *.auto* from device names given in usb_bind_phy (2013-12-16 17:44:43 -0600)

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      usb: musb: omap: remove using PLATFORM_DEVID_AUTO in omap2430.c
      arm: omap: remove *.auto* from device names given in usb_bind_phy

 arch/arm/mach-omap2/board-2430sdp.c        |  2 +-
 arch/arm/mach-omap2/board-3430sdp.c        |  2 +-
 arch/arm/mach-omap2/board-cm-t35.c         |  2 +-
 arch/arm/mach-omap2/board-devkit8000.c     |  2 +-
 arch/arm/mach-omap2/board-ldp.c            |  2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |  2 +-
 arch/arm/mach-omap2/board-omap3logic.c     |  2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |  2 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |  2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |  2 +-
 arch/arm/mach-omap2/board-overo.c          |  2 +-
 arch/arm/mach-omap2/board-rx51.c           |  2 +-
 drivers/usb/musb/musb_core.c               | 31 +++++++++++++++++++++++++++++-
 drivers/usb/musb/musb_core.h               |  2 ++
 drivers/usb/musb/omap2430.c                | 19 ++++++++++++++++--
 15 files changed, 61 insertions(+), 15 deletions(-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/a979ebc0/attachment-0001.sig>
