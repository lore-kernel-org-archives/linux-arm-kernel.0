From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Fri, 15 Jul 2016 11:01:10 +0200
Subject: outdated documentation for lp5523 LED driver?
In-Reply-To: <20160715085425.GA21257@amd>
References: <20160715073214.GC13429@amd> <20160715074052.GE29844@pali>
 <20160715085425.GA21257@amd>
Message-ID: <20160715090110.GF29844@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2016 10:54:25 Pavel Machek wrote:
> On Fri 2016-07-15 09:40:52, Pali Roh?r wrote:
> > On Friday 15 July 2016 09:32:14 Pavel Machek wrote:
> > > Hi!
> > > 
> > > Documentation says that load/leds are only visible in the load mode,
> > > but that does not seem to be true (kernel 4.4.0 on N900).
> > > 
> > > # 1) Legacy interface - enginex_mode, enginex_load and enginex_leds
> > > #  Control interface for the engines:
> > > #    x is 1 .. 3
> > > #      enginex_mode : disabled, load, run
> > > #      enginex_load : microcode load (visible only in load mode)
> > > #      enginex_leds : led mux control (visible only in load mode)
> > > 
> > > pavel at n900:/sys/class/leds/lp5523:r/device$ ls -al engine*
> > > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine1_leds
> > > --w------- 1 root root 4096 Jul  6 22:47 engine1_load
> > > -rw-r--r-- 1 root root 4096 Jul  6 23:41 engine1_mode
> > > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine2_leds
> > > --w------- 1 root root 4096 Jul  6 22:47 engine2_load
> > > -rw-r--r-- 1 root root 4096 Jul  6 23:41 engine2_mode
> > > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine3_leds
> > > --w------- 1 root root 4096 Jul  6 22:47 engine3_load
> > > -rw-r--r-- 1 root root 4096 Jul  6 22:47 engine3_mode
> > > pavel at n900:/sys/class/leds/lp5523:r/device$ grep . engine*mode
> > > engine1_mode:run
> > > engine2_mode:load
> > > engine3_mode:run
> > > pavel at n900:/sys/class/leds/lp5523:r/device$
> > 
> > On 2.6.28 kernel is present only legacy interface and for this version
> > is above documentation correct. When engine is in "run" or "disabled",
> > then sysfs nodes _load and _leds are invisible.
> 
> Well, I don't think 2.6.28 is suitable kernel to compare
> against... and I don't think hiding sysfs attributes makes any sense.

It is legacy interface which was used in older kernels (like 2.6.28) and
is there to not break existing applications... So comparing with kernel
when that interface was not legacy is correct way to check...

-- 
Pali Roh?r
pali.rohar at gmail.com
