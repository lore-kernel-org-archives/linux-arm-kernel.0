From: tony@atomide.com (Tony Lindgren)
Date: Tue, 2 Feb 2010 19:43:22 -0800
Subject: [PATCH 9/9] omap: Disable serial port autoidle by default
In-Reply-To: <20100203022618.26347.51428.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
	<20100203022618.26347.51428.stgit@baageli.muru.com>
Message-ID: <20100203034322.GZ22747@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100202 18:23]:
> Currently the omap serial clocks are autoidled after 5 seconds.
> However, this causes lost characters on the serial ports. As this
> is considered non-standard behaviour for Linux, disable the timeout.
> 
> Note that this will also cause blocking of any deeper omap sleep
> states.
> 
> To enable the autoidling of the serial ports, do something like
> this for each serial port:
> 
> # echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
> # echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
> ...

Turns out we also need to disable the timer in init, otherwise
the very first character after boot can get corrupt.

Updated version below, Kevin can you take one more look and see
if your S-O-B is still valid? :)

Regards,

Tony
