From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 20:10:45 +0000
Subject: [PATCH 2/6 v3] ARM: integrator: check PL010 base address from
 resource
In-Reply-To: <1346702775-19828-1-git-send-email-linus.walleij@linaro.org>
References: <1346702775-19828-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201209032010.46141.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Linus Walleij wrote:
> In the PL010 UART callback a comparison against the location of the
> statically allocated PL010 device is done to figure out which UART
> is doing the callback. This does not play well with dynamic devices
> such as in device tree, so let's check the base address of the
> memory resource inside the amba_device instead.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Check for the base address of the physical memory resource instead
>   of checking for the device name (which will also be dynamic when
>   we use device tree).

Ok, looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
