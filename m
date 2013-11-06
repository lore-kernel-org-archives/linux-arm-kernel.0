From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Nov 2013 09:46:04 +0100
Subject: [PATCH 20/23] ARM: signal: sigreturn_codes should be endian
 neutral to work in BE8
In-Reply-To: <CAA3XUr0RbbbB6md96DLW_XQXSB7K-qhggVcNeLxowS7xzZwdRA@mail.gmail.com>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <1381271679-27804-21-git-send-email-ben.dooks@codethink.co.uk>
 <20131105211807.GR14892@pengutronix.de>
 <CAA3XUr0RbbbB6md96DLW_XQXSB7K-qhggVcNeLxowS7xzZwdRA@mail.gmail.com>
Message-ID: <20131106084604.GU14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Victor,

On Tue, Nov 05, 2013 at 07:48:42PM -0800, Victor Kamensky wrote:
> Hi Uwe, and All,
> 
> On 5 November 2013 13:18, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> <snip>
> 
> >> +
> >> +#if __LINUX_ARM_ARCH__ <= 4
> >> +     /*
> >> +      * Note we manually set minimally required arch that supports
> >> +      * required thumb opcodes for early arch versions. It is OK
> >> +      * for this file to be used in combination with other
> >> +      * lower arch variants, since these code snippets are only
> >> +      * used as input data.
> >> +      */
> >> +     .arch armv4t
> >> +#endif
> >> +
> >> +     .section .rodata
> >> +     .global sigreturn_codes
> >> +     .type   sigreturn_codes, #object
> >> +
> >> +     .arm
> > This breaks a ARMv7-M build, see
> > http://arm-soc.lixom.net/buildlogs/misc/next-20131105-1-g2b29c44/buildall.arm.efm32_defconfig.log.failed
> 
> Could you please point to git tree and branch from which efm32_defconfig
> was built - I could not find such in my tree.
next-20131105 contains both, your patch and the efm32 support.
(i.e. git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
next/master)

The problem is, that armv7-M doesn't support ARM, only Thumb-2.
If you go the ifdef route, CONFIG_CPU_THUMBONLY is what you want to use.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
