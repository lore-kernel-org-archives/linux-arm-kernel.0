From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jan 2014 13:31:41 +0000
Subject: [PATCH 2/3 RESEND] mfd: tc3589x: Reform device tree probing
In-Reply-To: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
References: <1390481008-23900-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140123133141.GD8586@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This changes the following mechanisms in the TC3589x device tree
> probing path:
> 
> - Use the .of_match_table in struct device_driver to match the
>   device in the device tree.
> - Add matches for the proper compatible strings "toshiba,..."
>   and all sub-variants, just as is done for the .id matches.
> - Move over all the allocation of platform data etc to the
>   tc3589x_of_probe() function and follow the pattern of passing
>   a platform data pointer back, or an error pointer on error,
>   as found in the STMPE driver.
> - Match the new (proper) compatible strings for the GPIO and
>   keypad MFD cells.
> - Use of_device_is_compatible() rather than just !strcmp()
>   to discover which cells to instantiate.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/tc3589x.c | 84 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 25 deletions(-)

Patch looks good to me. Is there any reason why we should rush this in
for v3.14, or is it okay to go to -next?

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
