From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 18 Jun 2013 10:23:33 +0100
Subject: [PATCH 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <1371514129-22801-3-git-send-email-dinguyen@altera.com>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
 <1371514129-22801-3-git-send-email-dinguyen@altera.com>
Message-ID: <20130618092333.GA8641@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Mon, Jun 17, 2013 at 07:08:49PM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The read_sched_clock should return the ~value because the clock is a
> countdown implementation. read_sched_clock() should be the same as
> __apbt_read_clocksource().
> 
> If a separate timer for the sched_clock exist, then read_sched_clock()
> will return an incorrect value. The (sched_io_base + 0x4) needs to be in
> the function for both cases.

Actually the old behaviour is correct for picoxcell as we're using the 
DesignWare RTC rather than the counter block and the RTC does count 
upwards, but your change will work as we'll start using the regular 
timers anyway.

Looks good to me though.

Acked-by: Jamie Iles <jamie@jamieiles.com>

for the series.

Jamie
