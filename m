From: khilman@ti.com (Kevin Hilman)
Date: Fri, 22 Apr 2011 07:59:42 -0700
Subject: [RFC PATCH 03/18] OMAP: GPIO: Move gpio_get_index() to mach-omap
In-Reply-To: <1303470512-19671-4-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Fri, 22 Apr 2011 16:38:17 +0530")
References: <1303470512-19671-1-git-send-email-charu@ti.com>
	<1303470512-19671-4-git-send-email-charu@ti.com>
Message-ID: <87wrimz601.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Charulatha V <charu@ti.com> writes:

> gpio_get_index() uses cpu_is* checks. Move this function from
> plat-omap/gpio.c to SoC specific GPIO files in mach-omap*/ and
> use pdata to pass the function pointer.
>
> Signed-off-by: Charulatha V <charu@ti.com>

This one isn't really needed.  The index should be calculated by using
the bank width.

Below is a patch doing the same thing but using bitops and avoiding the
need for pdata function pointers.

Kevin
