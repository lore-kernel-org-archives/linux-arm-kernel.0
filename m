From: horms@verge.net.au (Simon Horman)
Date: Sun, 17 Aug 2014 09:37:48 +0900
Subject: [PATCH] ARM: shmobile: defconfig: enable initrd and atag dtb
 compat
In-Reply-To: <20140814052557.GA27045@verge.net.au>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
 <20140814052557.GA27045@verge.net.au>
Message-ID: <20140817003748.GA7887@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 02:25:57PM +0900, Simon Horman wrote:
> On Wed, Aug 13, 2014 at 05:07:15PM -0700, Kevin Hilman wrote:
> > Enable ATAG_DTB_COMPAT support for passing commandline from bootloader.
> > Enable initrd support.
> > 
> > Signed-off-by: Kevin Hilman <khilman@linaro.org>
> > ---
> > With this, I can finally integrate the kzm9d into the board farm because I use
> > initrafms for the primary rootfs, and set the command-line from u-boot.
> > 
> > Tested on next-20140813
> 
> Thanks, I will queue this up for v3.18 and push it to next
> once v3.17-rc1 has been released.

Hi Kevin,

I have decided to drop this patch for now as it appears to
cause my kzm9d (of all things) not to boot. And per a follow-up email
from you it no longer appears to be required in your environment.

I'm more than happy to revisit this if it turns out to be useful again.

> >  arch/arm/configs/shmobile_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > index 3b136144cc83..d655f088ac58 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
> >  CONFIG_IKCONFIG=y
> >  CONFIG_IKCONFIG_PROC=y
> >  CONFIG_LOG_BUF_SHIFT=16
> > +CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> >  CONFIG_SYSCTL_SYSCALL=y
> >  CONFIG_EMBEDDED=y
> > @@ -33,6 +34,7 @@ CONFIG_HIGHMEM=y
> >  CONFIG_ZBOOT_ROM_TEXT=0x0
> >  CONFIG_ZBOOT_ROM_BSS=0x0
> >  CONFIG_ARM_APPENDED_DTB=y
> > +CONFIG_ARM_ATAG_DTB_COMPAT=y
> >  CONFIG_KEXEC=y
> >  CONFIG_VFP=y
> >  CONFIG_NEON=y
> > -- 
> > 1.9.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
