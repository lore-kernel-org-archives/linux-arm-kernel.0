From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 07 Oct 2012 00:18:21 +0200
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121006161429.GD12462@game.jcrosoft.org>
References: <20121006161429.GD12462@game.jcrosoft.org>
Message-ID: <17531317.3PGnt12jPY@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 of October 2012 18:14:29 Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> The following changes since commit 5f3d2f2e1a63679cf1c4a4210f2f1cc2f335bef6:
> 
>   Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2012-10-06 03:16:12 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.jcrosoft.org/linux-2.6.git tags/pm_suspend_standby_mem
> 
> for you to fetch changes up to b73c8f97aa8e720bd3b921159687d00626c99d63:
> 
>   arm: at91: drop at91_suspend_entering_slow_clock (2012-10-06 18:06:25 +0800)
> 
> ----------------------------------------------------------------
> pm: add suspend_mem and suspend_standby support
> 
> Today when we go to suspend we can not knwon at drivers level if we go in
> STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
> suspend_standby.

No way. Device drivers shouldn't be concerned about that.

> If a bus or drivers does not need to care about this distinction we fallback to
> suspend. This will allow to do not update the current bus or drivers.
> 
> This is needed as example by at91 OHCI, UDC and atmel serial

I wonder why.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
