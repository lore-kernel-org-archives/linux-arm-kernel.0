From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Mon, 4 Mar 2013 08:57:51 -0300
Subject: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
In-Reply-To: <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
Message-ID: <CALF0-+V3A-fL7q2nPRmcgnFKmzRt8KwSLuzrwzyyce6MqHjVpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> +
> +Example:
> +
> +gpmc: gpmc at 6e000000 {
> +       compatible = "ti,omap3430-gpmc", "simple-bus";

I'm concern about using simple-bus, and I'm not entirely sure this will work.

AFAIK, you can't correlate a parent-child relationship in the device tree
to the order in which drivers will be probed,
so it's only a matter of coincidence if this is working for you right now.
The GPMC code is in "arch/arm/mach-omap2", is located *before* the mtd code
in the Makefile, and thus the GPMC driver loads *before* the MTD code.

Morevore, I believe that when we move GPMC from arch/arm/mach-omap2
to drivers/memory where it should be, this 'simple-bus' will stop
working properly.

Of course, I can be wrong, but I think you will have to find some other way
to initialize the GPMC's childs.

-- 
    Ezequiel
