From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 24 Feb 2016 17:20:46 +0100
Subject: [PATCH v2] clocksource: atmel-pit: register as a sched_clock
In-Reply-To: <1456329882-20709-1-git-send-email-romain.izard.pro@gmail.com>
References: <1456329882-20709-1-git-send-email-romain.izard.pro@gmail.com>
Message-ID: <20160224162046.GA28743@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 24, 2016 at 05:04:42PM +0100, Romain Izard wrote:
> Register the counter of the Periodic Interval Timer as a possible source
> for sched_clock. Keep the timer running even if the related clockevent
> is disabled.
> 
> This provides a better precision than the jiffies-based default. The
> TCB clocksource does not work, as it is registered too late in the
> initialization sequence.

I have mixed feelings about that, but this is probably just a 
misunderstanding from my part.

The PIT timer should not be used for systems with PM_SUSPEND enabled and 
used because it takes ages to synchronize on resume, how does this patch 
affect that ?

Ref: commit ac34ad27fc ("clockevents: Do not suspend/resume if unused")

Sylvain
