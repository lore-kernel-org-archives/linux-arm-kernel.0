From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Jul 2012 15:46:38 +0200
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <5000175E.4070702@gmail.com>
References: <1342182734-321-1-git-send-email-y>
 <5000175E.4070702@gmail.com>
Message-ID: <20120713134638.GH592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 07:41:02AM -0500, Rob Herring wrote:
> On 07/13/2012 07:32 AM, y at pengutronix.de wrote:
> > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > 
> > this series' goal is to make struct of_device_id.data const.
> > Conceptually a driver must not modify the data contained there so making
> > it const is the right thing.
> > 
> > This change might introduce warnings because drivers don't use const to
> > access the data pointed to by of_device_id.data. In most cases the fix
> > is to add some consts.
> > 
> > This series (apart from adding this const in patch 10) fixes all drivers
> > covered by all arm defconfigs (based on v3.5-rc6).
> > 
> 
> What about other arches?
I didn't looked at them, mainly because I don't have the scripts for
arches other than arm to do such testing. Also note that it introduces
only some warnings, but no breakage. So adding the const in the merge
window might be ok?!

I'm not sure I'll have the capacity to fix other arches now. Maybe only
add the const for ARCH=arm for now and I'll address the other archs as
time permits even though this is ugly? At least getting in patches 1-9
would be nice to get in to save me from keeping them up to date.

Which other arches do you consider relevant?

$ git grep -l '\<OF\>' arch/*/Kconfig
arch/arm/Kconfig
arch/c6x/Kconfig
arch/microblaze/Kconfig
arch/mips/Kconfig
arch/openrisc/Kconfig
arch/powerpc/Kconfig
arch/sparc/Kconfig
arch/x86/Kconfig

For most of these I first have to look where to get a toolchain from.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
