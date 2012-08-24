From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 12:54:47 -0700
Subject: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
In-Reply-To: <50359C64.40603@ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
 <50359C64.40603@ti.com>
Message-ID: <20120824195446.GV11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@TI.COM> [120822 19:58]:
> 
> So although this may consolidate how the timings are calculated today, I
> am concerned it will be confusing to add timings for a new device. At
> least if I am calculating timings, I am taking the timing information
> for the device and translating that to the how I need to program the
> gpmc register fields.

Yes agreed. Also as some values make sense only in cycles, converting them
back and forth to time is wrong. So at least some values should have an
option to specify them in cycles directly, and then ignore any time based
values.

Regards,

Tony
