From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Mar 2011 09:26:25 -0800
Subject: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
	requested pads
In-Reply-To: <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	<87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com>
	<AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
Message-ID: <20110308172625.GE26463@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Govindraj <govindraj.ti@gmail.com> [110308 03:43]:
> 
> I am not sure whether now we can control read/writes to pad_mux from any driver
> interface and I think we have to go through mux framework for any
> read/writes to mux.

Sure, the drivers should not mess with those registers directly.

> with this I cant control pad wake up capabilities with sysfs as done
> earlier in serial.c
> now control to read/write to pad is outside scope of the driver
> interface as omap_hwmod_mux
> is the one that takes decision for driver with mux values provided
> during omap_hwmod_mux_init.

The sysfs interface to control this should still be from the drivers.
Sounds like we need some way to set the wakeup flags before pm_runtime_put
is called.

Regards,

Tony
