From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 May 2016 22:11:37 -0400
Subject: [PATCH] ARM: exynos: don't select keyboard driver
In-Reply-To: <1463581102-1007639-1-git-send-email-arnd@arndb.de>
References: <1463581102-1007639-1-git-send-email-arnd@arndb.de>
Message-ID: <b20eb044-f575-9504-2446-ca74df9d1724@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 05/18/2016 10:17 AM, Arnd Bergmann wrote:
> The samsung-keypad driver is implicitly selected by ARCH_EXYNOS4 (why?),
> but this fails if CONFIG_INPUT is a loadable module:
> 
> drivers/input/built-in.o: In function `samsung_keypad_remove':
> drivers/input/keyboard/samsung-keypad.c:461: undefined reference to `input_unregister_device'
> drivers/input/built-in.o: In function `samsung_keypad_irq':
> drivers/input/keyboard/samsung-keypad.c:137: undefined reference to `input_event'
> drivers/input/built-in.o: In function `samsung_keypad_irq':
> include/linux/input.h:389: undefined reference to `input_event'
> drivers/input/built-in.o: In function `samsung_keypad_probe':
> drivers/input/keyboard/samsung-keypad.c:358: undefined reference to `devm_input_allocate_device'
> drivers/input/built-in.o:(.debug_addr+0x34): undefined reference to `input_set_capability'
> 
> This removes the 'select' as suggested by Krzysztof Kozlowski and
> instead enables the driver from the defconfig files.
> 
> The problem does not happen on mainline kernels, as we don't normally
> build built-in input drivers when CONFIG_INPUT=m, but I am experimenting
> with a patch to change this, and the samsung keypad driver showed up
> as one example that was silently broken before.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lkml.org/lkml/2016/2/14/55
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
