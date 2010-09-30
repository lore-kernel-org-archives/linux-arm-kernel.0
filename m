From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 30 Sep 2010 22:06:47 +0530
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <87k4m3jpus.fsf@deeprootsystems.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>,
	<87k4m3jpus.fsf@deeprootsystems.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF8141@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 

<<snip>>

> > With OMAP2PLUS watchdog implemented in hwmod fw way, the
> > module is reset during init.
> 
> Please drop this sentence, as it's not directly related to hwmod, but
> related to hardware reset, and was previously masked by most bootloaders.
> 

Okay, will modify accordingly.

> > After a watchdog timer module reset, the WDTs are enabled. The
> > default time for a system reset after a watchdog module reset
> > is ~10s as per the default value of the WDT registers. Hence
> > the system would be reset after 10s, if watchdog is not disabled
> > within 10s.
> >
> > This patch fixes the above issue by disabling the watchdog timer
> > after reset during initialization of devices.
> 
> Should also describe what happends if/when the watchdog driver is
> loaded.  

Okay. Will add it to the description.

> 
> Kevin
> 
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Reported-by: Kevin Hilman <khilman@deeprootsystems.com>

<<snip>>
