From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Jan 2017 13:15:28 +0100
Subject: [PATCH 55/62] watchdog: sunxi_wdt: Convert to use device managed
 functions and other improvements
In-Reply-To: <1484100561-17638-4-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-4-git-send-email-linux@roeck-us.net>
Message-ID: <20170111121528.lyp6dx2pm7ejd5bx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 06:09:09PM -0800, Guenter Roeck wrote:
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
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170111/51fbbf9a/attachment-0001.sig>
