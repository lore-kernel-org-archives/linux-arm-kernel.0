From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Oct 2013 14:36:52 +0100
Subject: [GIT PULL] Armada DRM support
In-Reply-To: <20131018151557.GA25034@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <20131018151557.GA25034@n2100.arm.linux.org.uk>
Message-ID: <20131022133652.GC25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 04:15:57PM +0100, Russell King - ARM Linux wrote:
> David,
> 
> Rob Clark has now reviewed this and has given his blessing for it to be
> pulled for the coming merge window.
> 
> This adds support for the Armada 510 display subsystem found on the
> Marvell Dove devices.  This IP is re-used across several different Marvell
> SoCs with various tweaks, and this driver has been structured to allow
> the other IPs to re-use the bulk of this code; further work in this area
> is expected from interested parties.
> 
> This has been extensively tested on the SolidRun Cubox platform and
> appears to work well there.

David,

The zero day tester found a problem with this building on some non-ARM.
Please add this fix to it, which Rob Clark has acked.  It's a small patch
to add a dependency on ARM.

Thanks.

The following changes since commit 585b691e2180e1501637050290292f77f5c30c7b:

  DRM: Armada: add support for drm tda19988 driver (2013-10-18 16:00:33 +0100)

are available in the git repository at:
  git://ftp.arm.linux.org.uk/~rmk/linux-cubox.git drm-tda998x-3.12-fixes

Russell King (1):
      DRM: Armada: depend on ARM

 drivers/gpu/drm/armada/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
