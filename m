From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 13:45:46 +0000
Subject: [PATCH 1/6] ARM: integrator: call common init function from
 machine
In-Reply-To: <1345119339-22638-1-git-send-email-linus.walleij@linaro.org>
References: <1345119339-22638-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201208161345.46346.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Linus Walleij wrote:
> There is currently a common integrator_init() function set up
> to be called from an arch_initcall(). The problem is that it is
> using machine_is_integrator() which is not working with device
> tree, let's call this from respective machine initilization
> function and add a parameter to tell whether it's the
> Integrator/AP or Integrator/CP instead.
> 
> There are still machine_is*() calls in the Integrator
> machines directory, but this one needs to be fixed lest we
> don't even get a UART console on the Integrator/AP after a
> Device Tree boot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
