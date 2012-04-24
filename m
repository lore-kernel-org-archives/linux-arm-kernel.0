From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 24 Apr 2012 10:33:01 +0000
Subject: [PATCH-V4 0/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
In-Reply-To: <CAMQu2gzHQ-ku3akGWqUGN+EC3Jo7LtXbohqfVT=fG4Y0VFttng@mail.gmail.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <CAMQu2gzHQ-ku3akGWqUGN+EC3Jo7LtXbohqfVT=fG4Y0VFttng@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FAAFA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 15:36:43, Shilimkar, Santosh wrote:
> On Tue, Apr 24, 2012 at 3:15 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> > Current OMAP code supports couple of clocksource options based
> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
> >
> > This patch series cleans up the existing 32k-sync timer implementation
> > without any major code changes, uses kernel parameter to override
> > the default clocksource of "counter_32k", also in order to support
> > some OMAP based derivative SoCs like AM33XX which doesn't have
> > 32K sync-timer hardware IP, adds hwmod lookup for omap2+
> > devices, and if lookup fails then fall back to gp-timer.
> >
> > if(use_gptimer_clksrc == true)
> > ? ? ? ?gptimer clocksource init;
> > else if (counter_32 init == false)
> > ? ? ? ?/* Fallback to gptimer */
> > ? ? ? ?gptimer clocksource init(;
> >
> > With this, we should be able to support multi-omap boot
> > including devices with/without 32k-sync timer.
> >
> > This patch-series has been boot tested on AM37xEVM platform, it
> > would be helpful if somebody help me to validate it on OMAP1/2
> > platforms.
> >
> > The patches are also available at -
> > https://github.com/hvaibhav/am335x-linux ? 32ksync-timer-cleanup
> >
> > History:
> > ========
> > Changes from V3:
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg66462.html
> > ? ? ? ?- Fixed all review comments from Kevin H
> > ? ? ? ? ? ? ? ?* Moved counter_32k CR register offset handling to
> > ? ? ? ? ? ? ? ? ?counter_32k.c file, so now, calling funtion don't have
> > ? ? ? ? ? ? ? ? ?to maintain or add offset to base addr.
> > ? ? ? ? ? ? ? ?* Added comment for funtion omap_init_clocksource_32k()
> > ? ? ? ? ? ? ? ?* Used resource_size() for calculate size
> > ? ? ? ? ? ? ? ?* Convert WARN_ON to pr_warn
> >
> Have given my reviewed-by on v2. Just quickly scanned the series
> based on above minor updates.
> Feel free to add,
> 
> 
Sorry, I missed to add your Reviewed-by here.

I believe this should be now last version, and should get merged by 
either Tony or Paul.

Tony & Paul,
Note to add line,
"Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>"


Thanks,
Vaibhav
