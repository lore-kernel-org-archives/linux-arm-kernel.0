From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jul 2015 15:32:45 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <alpine.DEB.2.11.1507031511180.3916@nanos>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
Message-ID: <20150703133245.GA19284@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> So with high res timers it boots. Can you please provide the output of
> /proc/timer_list for that case?

Sure:

Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 40752899169 nsecs

cpu: 0
 clock 0:
  .base:       c03aa990
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: tick_cpu_sched, tick_sched_timer, S:01
 # expires at 40760000000-40760000000 nsecs [in 7100831 to 7100831 nsecs]
 #1: sched_clock_timer, sched_clock_poll, S:01
 # expires at 21474836475000000-21474836475000000 nsecs [in 21474795722100831 to 21474795722100831 nsecs]
 clock 1:
  .base:       c03aa9c8
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c03aaa00
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c03aaa38
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 40760000000 nsecs
  .hres_active    : 1
  .nr_events      : 770
  .nr_retries     : 29
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 40400000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294941337
  .idle_calls     : 378
  .idle_sleeps    : 354
  .idle_entrytime : 40743316650 nsecs
  .idle_waketime  : 40743316650 nsecs
  .idle_exittime  : 40743377685 nsecs
  .idle_sleeptime : 37586425789 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 4294941368
  .next_jiffies   : 4294941389
  .idle_expires   : 40930000000 nsecs
jiffies: 4294941371

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: e0180000.timer
 max_delta_ns:   131071523464982
 min_delta_ns:   61035
 mult:           70369
 shift:          31
 mode:           3
 next_event:     40760000000 nsecs
 set_next_event: em_sti_clock_event_next
 set_mode:       em_sti_clock_event_mode
 event_handler:  hrtimer_interrupt
 retries:        0

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/f70827a7/attachment.sig>
