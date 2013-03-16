From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Mar 2013 14:56:54 +0000
Subject: [PATCH] clk: add DT test clock consumer driver
In-Reply-To: <1363439376-21294-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1363439376-21294-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201303161456.54246.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 March 2013, Sebastian Hesselbarth wrote:
> This driver adds a DT test clock consumer that exposes debugfs files to
> enable/disable and set/get rate of the attached programmable clock.
> During development of a i2c-attached clock generator I found it useful
> to debug the clock generator's internal pll settings by enforcing clock
> rates through debugfs.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

It sounds a little clumsy to have a device driver to match a device that
you create just for matching the driver.

Would it be possible to separate the debugging logic from the platform
device logic? I think it may be useful to have a debugfs or sysfs
inteface for all clocks in the system, even if that is disabled by
default or only available after manually loading a module implementing
that functionality.

	Arnd
