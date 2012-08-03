From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Aug 2012 11:32:54 +0200
Subject: [PATCH v5 0/3] Updated Cortex-M3 series
In-Reply-To: <20120803090235.GA26925@mudshark.cambridge.arm.com>
References: <1341512035-8173-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120803075807.GD2626@pengutronix.de>
 <20120803090235.GA26925@mudshark.cambridge.arm.com>
Message-ID: <20120803093254.GF2626@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On Fri, Aug 03, 2012 at 10:02:35AM +0100, Will Deacon wrote:
> On Fri, Aug 03, 2012 at 08:58:07AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Jul 05, 2012 at 08:13:52PM +0200, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > now that 3.5 is about to come I invested the time to update the
> > > beginning of the Cortex-M3 support.
> > > 
> > > Over all I rebased to v3.5-rc5 and addressed the comments by Russell.
> > > 
> > > It would be great to get these patches into next early after the merge
> > > window for 3.6 closes to get them into 3.7. But I won't argue if they
> > > made it into 3.6 ;-)
> > Now that v3.6-rc1 is out can these go into next for the next merge
> > window?
> 
> Last time I looked at the code, patch 3/3 was adding some fairly noisy debug
> prints to various syscalls and pieces of signal handling. e.g.:
> 
> 
> diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
> index 76cbb05..ea207df 100644
> --- a/arch/arm/kernel/sys_arm.c
> +++ b/arch/arm/kernel/sys_arm.c
> @@ -102,6 +102,7 @@ int kernel_execve(const char *filename,
>  	 * We were successful.  We won't be returning to our caller, but
>  	 * instead to user space by manipulating the kernel stack.
>  	 */
> +	pr_info("we were successful\n");
>  	asm(	"add	r0, %0, %1\n\t"
>  		"mov	r1, %2\n\t"
>  		"mov	r2, %3\n\t"
Huh, I removed them from arch/arm/kernel/signal.c and
arch/arm/kernel/sys_arm.c now and will resend in a moment. Thanks for
catching that.
I saw them when testing on an arm11, but was sure they were introduced
in a later patch on the stack.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
