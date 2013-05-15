From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 May 2013 10:43:00 +0200
Subject: [PATCH] ARM: sunxi: New watchdog driver for Allwinner A10/A13
In-Reply-To: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com>
References: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com>
Message-ID: <51934A94.3070503@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 12/05/2013 22:36, Carlo Caione a ?crit :
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.

I'd like to start some more general discussion here.

All the sunxi boards don't have a PMIC to do the reset properly, so we
chose to do the reboot hook using the watchdog.

How is that handled usually? Obviously, we could have a rather minimal
approach, like this one, where we have code duplication between the arch
code and the watchdog driver code, which is probably not so nice, but I
couldn't find either any convention for this, or a piece of
infrastructure to do so.

What could be the preferred solution?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
