From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 09:46:07 +0200
Subject: [PATCHv2 0/7] i2c: omap: updates
In-Reply-To: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121105074607.GA32468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Sun, Nov 04, 2012 at 04:14:26PM +0530, Shubhrajyoti D wrote:
> Does the followiing
> - Make the revision a 32- bit consisting of rev_lo amd rev_hi each
> of 16 bits.
> 
> - Also use the revision register for the erratum i207.
> - Refactor the i2c_omap_init code.
> 
> 
> Also more cleanup is possible will check on that subsequently.
> 
> 
> Tested on OMAP4430sdp  ,4460 ,omap3630 ,3430 and omap2430.
> 
> For omap2 testing the below patch was used
> [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3 set
> 
> Also for using the pm testing below patches are used.
> 
> arm: sched: stop sched_clock() during suspend
> ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
> 
> Also available through
> git://gitorious.org/linus-tree/linus-tree.git i2c_omap/for_3.8
> 
> 
> Shubhrajyoti D (7):
>   i2c: omap: Fix the revision register read
>   i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
>   i2c: omap: remove the dtrev
>   ARM: i2c: omap: Remove the i207 errata flag
>   i2c: omap: re-factor omap_i2c_init function
>   i2c: omap: make reset a seperate function
>   i2c: omap: Restore i2c context always
> 
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +-
>  drivers/i2c/busses/i2c-omap.c              |  166 +++++++++++++++++-----------
>  include/linux/i2c-omap.h                   |    1 -
>  4 files changed, 104 insertions(+), 75 deletions(-)

since I have reviewed your previous version, it would be nice to Cc me
so I don't loose your series ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/c09c236e/attachment.sig>
