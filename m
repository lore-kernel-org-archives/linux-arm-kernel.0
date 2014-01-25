From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 25 Jan 2014 10:12:37 -0800
Subject: [PATCH v4 04/18] watchdog: orion: Use atomic access for shared
 registers
In-Reply-To: <1390431915-5115-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52E3FE95.5040906@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> Since the timer control register is shared with the clocksource driver,
> use the recently introduced atomic_io_clear_set() to access such register.
> Given the watchdog core already provides serialization for all the
> watchdog ops, this commit allows to remove the spinlock entirely.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
