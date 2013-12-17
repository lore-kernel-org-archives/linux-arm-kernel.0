From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Dec 2013 14:28:15 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
Message-ID: <20131217132815.GJ14866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Dec 13, 2013 at 11:16:51PM +0100, Uwe Kleine-K?nig wrote:
> the following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
> 
> for you to fetch changes up to c24eb46490c8232c08c82cd591ba332284d257b2:
> 
>   ARM: drop <mach/timex.h> for !ARCH_MULTIPLATFORM, too (2013-12-07 23:31:28 +0100)
> 
> I'd like to get these changes into 3.14-rc1, so it would be great if you
> could take it into armsoc for some exposure into next.
> 
> The kbuild test robot is happy with these changes, and I did several
> build tests, too, so I don't expect any breakage.
> 
> Merging this series will result in a few merge conflicts. I pushed a
> branch dropmachtimexh-merged into my repository where you can see how I
> resolved them merging in current next/master into my tag.
> 
> ----------------------------------------------------------------
> This cleanup series gets rid of <mach/timex.h> for platforms not using
> ARCH_MULTIPLATFORM. (For multi-platform code it's already unused since
> 387798b (ARM: initial multiplatform support).)
> 
> To make this work some code out of arch/arm needed to be adapted. Apart from two
> changes in drivers/rtc I got the relevant maintainer Acks. For the rtc changes
> I didn't get any feedback by Alexandro Zummo since I posted the first change 5
> weeks ago despite pinging it several times. The current state seems to be that
> Andrew Morton takes odd fixes, but I couldn't get him to give an Ack either.
> (One of the two patches is in his queue, but I expect him to drop that as soon
> as the patch makes it in via another path. Didn't get any feedback here, too.)
In the meantime I got Acks for the rtc changes by apkm. I updated my tag
to include these two. It now points on
b5ea554282d15d14270e5a5ff80418d8d6410f85. The tag-log is updated
accordingly:

------
This cleanup series gets rid of <mach/timex.h> for platforms not using
ARCH_MULTIPLATFORM. (For multi-platform code it's already unused since
387798b (ARM: initial multiplatform support).)

To make this work some code out of arch/arm needed to be adapted. The
respective changes got acks by their maintainers to be taken via armsoc
(with Andrew Morton substituting for Alessandro Zummo as rtc maintainer).
------

The patches are unchanged.

Please pull for 3.14-rc1.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
