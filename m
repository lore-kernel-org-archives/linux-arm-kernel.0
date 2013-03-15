From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 14:47:05 +0000
Subject: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
In-Reply-To: <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
 <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201303151447.06150.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Daniel Lezcano wrote:
> The cpuidle drivers are duplicating a lot of code and in most
> of the case there is a common pattern we can factor out:
> 
>         * setup the broadcast timers
>         * register the driver
>         * register the devices
> 
> This arm driver is the common part between all the ARM cpuidle drivers,
> with the code factored out.
> 
> It does not handle the coupled idle state for now but it is the first
> step to have everyone to converge to the same code pattern.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Unfortunately, I missed the session in Hong Kong, but I'd like to understand
what part of this driver is actually ARM specific. I assume there is nothing
in it that depends on 32 bit ARM hardware, right?

Would the same code be used with arch/arm64?

What about other architectures that want to share a cpuidle driver
with and ARM SoC using the same hardware? We have a lot of examples
of SoC vendors that use similar components on ARM and non-ARM SoCs
based on SH, AVR32, Hexagon, C6x, MIPS or PowerPC.

	Arnd
