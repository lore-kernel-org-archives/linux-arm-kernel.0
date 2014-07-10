From: ceh@ti.com (Carlos Hernandez)
Date: Thu, 10 Jul 2014 12:03:29 -0400
Subject: [PATCH 6/6] tty: serial: Add 8250-core based omap driver
In-Reply-To: <53BEB5AF.7010604@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-7-git-send-email-bigeasy@linutronix.de>
 <20140710070948.GH28884@atomide.com> <53BEB5AF.7010604@linutronix.de>
Message-ID: <53BEB951.2040207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 11:47 AM, Sebastian Andrzej Siewior wrote:
> That core_pwrdm shows only up on dra7. However with both drivers (mine
> and the current omap serial) the UART went down after three secs (as
> expected) and didn't accept any characters while writing on the
> console. If I wrote something on it via network (like echo a >
> /dev/ttyO0) it came back and was working as long as I kept it busy. The
> thing is that RX does not wake it up. Any idea?

To wakeup from UART you need:
1) Append no_console_suspend to bootargs
2) echo enabled > /sys/devices/ocp.3/4806a000.serial/tty/ttyO0/power/wakeup
