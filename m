From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 12:23:02 -0700
Subject: PM regression with LED changes in next-20161109
Message-ID: <20161109192301.GS26979@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
the sysfs brightness attr for changes.") breaks runtime PM for me.

On my omap dm3730 based test system, idle power consumption is over 70
times higher now with this patch! It goes from about 6mW for the core
system to over 440mW during idle meaning there's some busy timer now
active.

Reverting this patch fixes the issue. Any ideas?

Regards,

Tony
