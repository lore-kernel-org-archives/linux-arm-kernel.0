From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Apr 2014 11:20:24 +0100
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <5096140.xI07lv1NXD@wuerfel>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <20140423074451.GE2523@dragon>
 <20140423090014.GE24070@n2100.arm.linux.org.uk> <5096140.xI07lv1NXD@wuerfel>
Message-ID: <20140426102023.GX26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 11:36:42PM +0200, Arnd Bergmann wrote:
> On Wednesday 23 April 2014 10:00:14 Russell King - ARM Linux wrote:
> > 
> > Yes, those ones were trivial to sort out, and as you point out were well
> > known well before the merge window.  Those aren't the ones I'm actually
> > talking about - half way through the merge window, some major conflicts
> > cropped up which caused _me_ to drop arm-soc out of my autobuilder, and
> > caused Stephen to ignore arm-soc's version of the file(s):
> > 
> >    Today's linux-next merge of the arm-soc tree got conflicts in
> >    arch/arm/boot/dts/qcom-msm8960.dtsi, arch/arm/boot/dts/qcom-msm8974.dtsi,
> >    arch/arm/mach-omap2/pdata-quirks.c, arch/arm/mach-zynq/Kconfig,
> >    drivers/watchdog/Kconfig and sound/soc/kirkwood/Kconfig between various
> >    merge commits from Linus' tree and various merge commits from the arm-soc
> >    tree.
> > 
> >    I used the versions from Linus' tree.
> > 
> 
> That was the day after Linus had merged arm-soc and used a different
> set of resolutions than what I had put into for-next as examples
> for him to look at.
> 
> The conflicts that Stephen saw were between Linus' resolution and mine,
> but at that point there were no more unmerged patches in arm-soc, just
> stale merge changesets.
> 
> > What is really interesting is that there are no acks from arm-soc people
> > for this patch.  If they want me to take it, they can damned well provide
> > an ack after having their moan at me during the merge window.  And I'm
> > not talking just about Arnd, but Olof as well.  I'm going to require *both*
> > to ack any changes to arch/arm/boot/dts in future so that I can be certain
> > that they are *both* aware of what's going on.
> 
> Olof already gave an (informal) Ack. Here is mine as well:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I'll take it with your ack now, but I'm not adding an ack for Olof given
the vagueness of his reply in this thread.  To do so would be to invite
accusations of adding acks where none was intended, and I decided right
from the beginning of these attributations that they *must* be explicit
to avoid any possibility of confusion and ambiguity (and I said as much.)

"informal" acks are not acks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
