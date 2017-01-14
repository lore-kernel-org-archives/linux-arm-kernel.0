From: eric@anholt.net (Eric Anholt)
Date: Fri, 13 Jan 2017 22:27:32 -0800
Subject: [PATCH 05/62] watchdog: bcm2835_wdt: Convert to use device
 managed functions and other improvements
In-Reply-To: <1484091325-9199-6-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484091325-9199-6-git-send-email-linux@roeck-us.net>
Message-ID: <87fukmi2az.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Drop assignments to otherwise unused variables
> - Replace of_iomap() with platform_get_resource() followed by
>   devm_ioremap_resource()

Every time I see this pattern I wish we had a
devm_ioremap_platform_resource().

> - Replace &pdev->dev with dev if 'struct device *dev' is a declared
>   variable
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()

I'm trusting you here that this last change is right.  All the rest of
it looks good:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170113/817a1030/attachment.sig>
