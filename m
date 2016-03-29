From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 10:05:58 +0200
Subject: [PATCH] arm: remove tautologic #ifdefs in proc-v7-3level.S
In-Reply-To: <1459237071-13842-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
References: <1459237071-13842-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <3570872.7QPkonuD2y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 09:37:51 Jonas Rabenstein wrote:
> The file arch/arm/mm/proc-v7-3level.S is only used by the #include
> directive in arch/arm/mm/proc-v7.S:23. This #include is conditional and
> depends on  CONFIG_ARM_LPAE (otherwise proc-v7-2level.S is used).
> CONFIG_ARM_LPAE has a dependency on CONFIG_MMU defined in Kconfig.
> Consequently, checks for CONFIG_MMU in proc-v7-3level.S are superfluous.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  I detected the issue with chimaera, a tool I currently develop for my bachelor
>  thesis extending the undertaker tool suite (https://undertaker.cs.fau.de).

Nice catch!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I guess you should submit the same thing for the other file as well,
either in the same patch or as a series.

You can also add

Fixes: 8d2cd3a38fd6 ("ARM: LPAE: Factor out classic-MMU specific code into proc-v7-2level.S")

to mark the commit that led to the situation.

	Arnd
