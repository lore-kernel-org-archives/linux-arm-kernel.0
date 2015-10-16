From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 16 Oct 2015 20:11:29 +0200
Subject: Atmel SoCs and the newly added CONFIG_DELAY_DEVICE_PROBES option
Message-ID: <20151016181129.GA1764@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

FYI, to save you a git bisect, the recently added 
CONFIG_DELAY_DEVICE_PROBES (enabled by default) breaks Atmel SoCs.

For a few of quickly noticeable issues:
- PM is not working:   at91_pm_sram_init: sram pool unavailable!
- Watchdog is not even probed
- on -ek boards the wm8904 is not probed either.

Disabling CONFIG_DELAY_DEVICE_PROBES fixes all issues.

Tomeu, what should I provide to help find out what's happening ?

Sylvain
