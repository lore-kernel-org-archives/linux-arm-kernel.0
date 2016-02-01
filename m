From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Feb 2016 14:11:12 -0800
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160201211736.GA11283@amd>
References: <20160123121022.GB12497@amd> <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd> <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd> <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd> <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
Message-ID: <20160201221111.GP19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [160201 13:18]:
> 
> No, sorry, that was with 4.4. As you hit "PM regression with commit
> 5de85b9d57ab PM runtime re-init in v4.5-rc1", I thought I'd avoid
> v4.5-rc. 

OK

> (I assume I have to insmod and rmmod, right? Because powersave is not
> entered if I simply compile-out usb).

Depending on what the bootloader does and probably also if
USB was used during the booting.. So yeah you may need to modprobe
and then rmmod.

> Would you have commit ids for those rmmod fixes? It might be good to
> push them into stable, and I should try again with them applied...

055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")

Regards,

Tony
