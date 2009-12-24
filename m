From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Dec 2009 12:09:21 +0100
Subject: [RFC][PATCH 2/14] Convert arm to read/update_persistent_clock
In-Reply-To: <1261540902.3508.63.camel@localhost.localdomain>
References: <1261540762.3508.61.camel@localhost.localdomain>
	<1261540826.3508.62.camel@localhost.localdomain>
	<1261540902.3508.63.camel@localhost.localdomain>
Message-ID: <20091224110921.GA14511@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Dec 22, 2009 at 08:01:42PM -0800, john stultz wrote:
> This patch converts the arm architecture to use the generic
> read_persistent_clock and update_persistent_clock interfaces, reducing
> the amount of arch specific code we have to maintain, and allowing for
> further cleanups in the future.
> 
> Also removes a direct xtime access, replacing it with
> current_kernel_time()
> 
> I have not built or tested this patch, so help from arch maintainers
> would be appreciated.
I havn't tested either, but built footbridge_defconfig successfully.
bloat-o-meter reports:

add/remove: 4/1 grow/shrink: 2/2 up/down: 388/-196 (192)
function                                     old     new   delta
sync_cmos_clock                                -     240    +240
update_persistent_clock                        -      52     +52
sync_cmos_work                                 -      40     +40
do_adjtimex                                 1924    1956     +32
save_time_delta                               56      76     +20
no_sync_cmos_clock                             -       4      +4
next_rtc_update                                4       -      -4
set_isa_cmos_time                            372     364      -8
timer_tick                                   324     140    -184

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
