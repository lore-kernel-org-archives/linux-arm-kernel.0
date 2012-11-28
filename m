From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 28 Nov 2012 11:38:51 +0000
Subject: [PATCH] mfd: vexpress-sysreg: Remove LEDs code
In-Reply-To: <50B4FFB2.6050601@wwwdotorg.org>
References: <1353332344-16754-1-git-send-email-pawel.moll@arm.com>
 <20121121085539.GR7615@quad.lixom.net>
 <CAOesGMgJqPCXNxfEA+=NVE_yMtSKS_vnzNkT9Of9bqw0t5iMww@mail.gmail.com>
 <50B4FFB2.6050601@wwwdotorg.org>
Message-ID: <1354102731.2987.18.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-27 at 18:00 +0000, Stephen Warren wrote:
> On 11/21/2012 02:04 AM, Olof Johansson wrote:
> > On Wed, Nov 21, 2012 at 12:55 AM, Olof Johansson <olof@lixom.net> wrote:
> >> On Mon, Nov 19, 2012 at 01:39:04PM +0000, Pawel Moll wrote:
> >>> As the current LEDs code breaks other platform, remove it.
> >>>
> >>> It shall be replaced by a generic "MMIO LEDs" driver.
> >>>
> >>> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> >>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> >>> ---
> >>>  drivers/mfd/vexpress-sysreg.c |   77 -----------------------------------------
> >>>  1 file changed, 77 deletions(-)
> >>>
> >>> Hi Arnd,
> >>>
> >>> As I haven't managed to get any feedback on the generic MMIO
> >>> LEDs driver so far, I have to postpone it till next cycle and
> >>> completely remove the LED-related code from the vexpress-sysreg
> >>> driver, as it breaks other platforms today.
> >>>
> >>> Would you be so kind to apply this patch, please? Alternatively
> >>> you can pull it from here:
> >>>
> >>>   git://git.linaro.org/people/pawelmoll/linux.git vexpress-soc2
> >>>
> >>> (this branch is based on the vexpress-soc you already have)
> >>
> >> Applied the patch on top of vexpress/soc, and merged in that branch into
> >> next/soc again (it had been reverted due to the issues)
> > 
> > Actually, I replaced our current vexpress/soc with the latest one you
> > had sent a pull request from before, since it had the appropriate
> > dependencies with the clock tree sorted out
> > (git://git.linaro.org/people/pawelmoll/linux.git vexpress-clk-soc).
> 
> In next-20121127, I still see that drivers/mfd/vexpress-sysreg.c has the
> following code:
> 
> > static int __init vexpress_sysreg_init_leds(void)
> > {
> >         struct vexpress_sysreg_led *led;
> >         int i;
> > 
> >         /* Clear all user LEDs */
> >         writel(0, vexpress_sysreg_base + SYS_LED);
> ...
> > }
> > device_initcall(vexpress_sysreg_init_leds);
> 
> ... and on systems where vexpress_sysreg_base is not set, this crashes
> the kernel on boot.
> 
> Shouldn't the patch "mfd: vexpress-sysreg: Remove LEDs code" be applied
> to solve this?

By all means... I had an impression that Olof re-pulled the
vexpress-soc2 branch which has it, but apparently not.

Olof, would you be so kind to apply the patch then?

Cheers!

Pawe?
