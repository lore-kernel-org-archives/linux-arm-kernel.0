From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 17 Nov 2015 10:37:40 +0100
Subject: [PATCH] clocksource: fsl: avoid harmless 64-bit warnings
In-Reply-To: <3990834.xnjhm37Grs@wuerfel>
References: <3990834.xnjhm37Grs@wuerfel>
Message-ID: <564AF564.6080406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 05:34 PM, Arnd Bergmann wrote:
> The ftm_clockevent_init passes the value of "~0UL" into a function
> that takes a 32-bit argument, which drops the upper 32 bits, as
> gcc warns about on ARM64:
>
> clocksource/fsl_ftm_timer.c: In function 'ftm_clockevent_init':
> clocksource/fsl_ftm_timer.c:206:13: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>
> This was obviously unintended behavior, and is easily avoided by
> using '~0u' as the integer literal, because that is 32-bit wide
> on all architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd for the fix. I will apply it on top of branch.
