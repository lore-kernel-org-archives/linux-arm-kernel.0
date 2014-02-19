From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Feb 2014 22:41:04 -0800
Subject: [GIT PULL v2] get rid of <mach/timex.h>
In-Reply-To: <20140218213736.GA6988@pengutronix.de>
References: <20140218213736.GA6988@pengutronix.de>
Message-ID: <20140219064104.GA24381@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:37:36PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> the following changes since commit 6a79799d5654bb7800614e8b7a009252be7ff90e:
> 
>   ARM: u300: fix timekeeping when periodic mode is used (2013-11-26 21:00:21 +0100)
> 
> (which is v3.13-rc1 + 3 commits that were merged into 3.14-rc1)
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh-v2
> 
> for you to fetch changes up to fb3174e4ad2427c6ad90c67093d6ca97f13e8672:
> 
>   ARM: ixp4xx: fix timer latch calculation (2014-02-18 21:23:19 +0100)
> 
> ----------------------------------------------------------------
> This cleanup series gets rid of <mach/timex.h> for platforms not using
> ARCH_MULTIPLATFORM. (For multi-platform code it's already unused since
> 387798b (ARM: initial multiplatform support).)
> 
> To make this work some code out of arch/arm needed to be adapted. The
> respective changes got acks by their maintainers to be taken via armsoc
> (with Andrew Morton substituting for Alessandro Zummo as rtc maintainer).
> 
> Compared to the previous pull request there was another patch added that
> fixes a (non-critical) regression on ixp4xx. Olof Johansson asked to not
> squash this fix into the original commit to save him from the need to
> reverify the series.
> 
> ----------------------------------------------------------------
> 
> The series still creates the same merge conflicts when being pulled into
> linus/master. See
> http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=dropmachtimexh-merged
> for how I resolved for the first pull request.
> 
> It would be great to get this merged into v3.15-rc1.

Merged in as cleanup/timex-removal into next/cleanup.

Note that your conflict resolution was incorrect at least for the
mach-sa1100 case, where the SA1100_LATCH define is still needed.


-Olof
