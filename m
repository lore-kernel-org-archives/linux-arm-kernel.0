From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 2 Mar 2011 22:42:43 +0530
Subject: [PATCH 1/1] davinci: changed SRAM allocator to shared ram.
In-Reply-To: <25DBF349769A4CF7B883D6D7FF01AD70@subhasishg>
References: <1297434088-27995-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BE49175@dbde02.ent.ti.com>
	<886E26C48DE446C3937D89ECF86030B2@subhasishg>
	<B85A65D85D7EB246BE421B3FB0FBB593024BE49711@dbde02.ent.ti.com>
	<25DBF349769A4CF7B883D6D7FF01AD70@subhasishg>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C0082E3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Subhasish,

On Sat, Feb 26, 2011 at 17:42:39, Subhasish Ghosh wrote:
> Hi Sekhar,
> 
> I tried this using MMC and Kelvin's suggestions, but it never came back. 
> Here is a log:

Was this result with or without this patch applied?

> 
> root at arago:~# rtcwake -d /dev/rtc0 -s 20 -m mem
> wakeup from "mem" at Tue Apr 21 14:31:13 2009
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.01 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> 
> From the Kconfig I had enabled RTC_DRV_OMAP, CONFIG_PM, CONFIG_SUSPEND.

Nothing stands out from these logs. One thing to
verify is if the RTC Alarm interrupt is really
working by using the test program present in the
Documentation/ folder.

Anyway, the easiest way for you to move quickly is
to use ramdisk so you can bypass all driver specific
issues.

Thanks,
Sekhar
