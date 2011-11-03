From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 Nov 2011 14:44:13 -0700
Subject: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 5 Oct 2011 14:02:49 +0530")
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87obwsg9ua.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.

Using this series on 3630/Zoom3, UART wakeups no longer work from
suspend.  That suggests that GPIO wakeups from retention/off are not
working.

Please test GPIO wakeups from retention/off.  One way is to use Zoom3
UART wakeup from suspend using by enabling UART wakeups and suspending:

   # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
   # echo mem > /sys/power/state

Also, this series now has a handful of minor conflicts with stuff that
is queued or merged for v3.2.  Please rebase onto 

   git://github.com/khilman/linux-omap-pm.git for_3.3/gpio-base

Kevin
