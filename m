From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 Jan 2014 09:36:27 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
In-Reply-To: <20140113084920.GE29308@verge.net.au>
References: <1389525349-3722-1-git-send-email-geert@linux-m68k.org>
 <20140113003811.GI15296@verge.net.au>
 <CAMuHMdWu80dtY_uKtd-t4eYQw3c4Vu=AqbTZ1CnDtc6yeyXiYQ@mail.gmail.com>
 <20140113084920.GE29308@verge.net.au>
Message-ID: <20140114003627.GB18217@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 05:49:20PM +0900, Simon Horman wrote:
> On Mon, Jan 13, 2014 at 09:02:07AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Jan 13, 2014 at 1:38 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Sun, Jan 12, 2014 at 12:15:49PM +0100, Geert Uytterhoeven wrote:
> > >> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> > >>
> > >> Without this, a Debian jessie nfsroot hangs early in the boot process.
> > >
> > > If this is really necessary for Jessie to boot then I think
> > 
> > I think it's needed for udev. Looking in the git history for similar changes
> > to other defconfigs confirmed that.
> 
> Ok, thanks.
> 
> > > we should enabled it in all shmobile defconfigs.
> > 
> > Sure. Do you want me to send patches for that, or will you take care yourself?
> 
> If you have time to prepare patches that would be great.
> Else I can do it myself.

In the mean time I will queue this up. In doing so I had to resolve
a minor conflict. The result is as follows. Please check it.

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig

Without this, a Debian jessie nfsroot hangs early in the boot process.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
[horms+renesas at verge.net.au: resolved trivial conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 4071e61..3015797 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -34,6 +34,8 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
