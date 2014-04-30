From: jays.lee@samsung.com (Jungseok Lee)
Date: Wed, 30 Apr 2014 11:32:32 +0900
Subject: [PATCH v4 1/7] arm64: Use pr_* instead of printk
In-Reply-To: <vnkwsioveuwk.fsf@mitchelh-linux.qualcomm.com>
References: <000101cf6367$c4c219f0$4e464dd0$@samsung.com>
 <vnkwsioveuwk.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <007c01cf641c$708af310$51a0d930$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 30, 2014 5:35 AM, Mitchel Humpherys wrote:
> On Mon, Apr 28 2014 at 09:59:14 PM, Jungseok Lee <jays.lee@samsung.com> wrote:
> > This patch fixed the following checkpatch complaint as using pr_*
> > instead of printk.
> >
> > WARNING: printk() should include KERN_ facility level
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> > Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
> > ---
> >  arch/arm64/kernel/traps.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 7ffaddd..0484e81 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -65,7 +65,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
> >  	fs = get_fs();
> >  	set_fs(KERNEL_DS);
> >
> > -	printk("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
> > +	pr_emerg("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
> 
> Currently this printk is being called with lvl=KERN_EMERG or lvl="". In the case of lvl=KERN_EMERG
> leaving lvl in is redundant. In the case of lvl="" this is a behavioral change (printing to a
> different log level). Was this intended?

No intention. I will drop the change in the next version.
Thanks!!

Best Regards
Jungseok Lee
