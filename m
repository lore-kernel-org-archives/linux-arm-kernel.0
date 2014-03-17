From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 19:46:54 +0100
Subject: [PATCH] ARM: prima2: build reset code standalone
In-Reply-To: <3158149.XI9lgY9por@wuerfel>
References: <3158149.XI9lgY9por@wuerfel>
Message-ID: <201403171946.54825.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 March 2014, Arnd Bergmann wrote:
> The prima2 platform code currently depends on the rstc
> implementation and that in turn depends on the reset
> controller framework. This removes the platform dependency
> by letting the driver access arm_pm_restart directly
> to turn the driver into a standalone entity, and also
> removes the dependency on the reset controller framework
> by using "if (IS_ENABLED(CONFIG_RESET_CONTROLLER))". This
> will cause all code that is used for the reset controller
> to be dropped by the compiler if the framework is disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> The problem only shows up in our for-next branch, I'd apply the
> patch right away if I get an Ack.

Applied to next/cleanup now, which introduced the problem.

	Arnd
