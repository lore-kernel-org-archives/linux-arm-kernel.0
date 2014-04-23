From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Apr 2014 10:00:14 +0100
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140423074451.GE2523@dragon>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <CAOesGMiDqd+JSd_fzzeWohSGixuR1ciOz_FO5CGnSm7F3ioxDw@mail.gmail.com>
 <20140421233148.GZ2523@dragon> <201404222249.07486.arnd@arndb.de>
 <20140422215506.GC24070@n2100.arm.linux.org.uk>
 <20140423074451.GE2523@dragon>
Message-ID: <20140423090014.GE24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 03:44:53PM +0800, Shawn Guo wrote:
> On Tue, Apr 22, 2014 at 10:55:06PM +0100, Russell King - ARM Linux wrote:
> > So care to explain why there were _zero_ merge conflicts from -rc time
> > before the merge window up to about a week _into_ the merge window, and
> > then suddenly arm-soc starts conflicting not only locally here but _also_
> > in linux-next.
> > 
> > That stinks of arm-soc merging new stuff *during* the merge window.
> 
> I'm not sure that's the case.
> 
> It seems to me that the merge conflict was reported by Stephen Rothwell
> one month ahead of the merge window [1].

Yes, those ones were trivial to sort out, and as you point out were well
known well before the merge window.  Those aren't the ones I'm actually
talking about - half way through the merge window, some major conflicts
cropped up which caused _me_ to drop arm-soc out of my autobuilder, and
caused Stephen to ignore arm-soc's version of the file(s):

   Today's linux-next merge of the arm-soc tree got conflicts in
   arch/arm/boot/dts/qcom-msm8960.dtsi, arch/arm/boot/dts/qcom-msm8974.dtsi,
   arch/arm/mach-omap2/pdata-quirks.c, arch/arm/mach-zynq/Kconfig,
   drivers/watchdog/Kconfig and sound/soc/kirkwood/Kconfig between various
   merge commits from Linus' tree and various merge commits from the arm-soc
   tree.

   I used the versions from Linus' tree.

In comparison to those, both Stephen and myself came up with the same
trivial resolutions for the DT files.  Moreover, as I've already said to
Arnd, the reason these changes went via the staging tree is so that we
could _keep_ imx-drm workable and testable for everyone - splitting the
change up into the DT bits for arm-soc and the rest for the staging tree
would have resulted in breakage.

So... whatever way I don't think arm-soc has a leg to stand on.  They
cocked up during the merge window.

What is really interesting is that there are no acks from arm-soc people
for this patch.  If they want me to take it, they can damned well provide
an ack after having their moan at me during the merge window.  And I'm
not talking just about Arnd, but Olof as well.  I'm going to require *both*
to ack any changes to arch/arm/boot/dts in future so that I can be certain
that they are *both* aware of what's going on.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
