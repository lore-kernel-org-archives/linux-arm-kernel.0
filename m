From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 14 Jul 2016 15:34:05 -0700
Subject: [PATCH 1/4] bus: brcmstb_gisb: make it explicitly non-modular
In-Reply-To: <20160703173040.23612-2-paul.gortmaker@windriver.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
 <20160703173040.23612-2-paul.gortmaker@windriver.com>
Message-ID: <5788135D.9000500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2016 10:30 AM, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
> 
> config BRCMSTB_GISB_ARB
>         bool "Broadcom STB GISB bus arbiter"
> 
> ...meaning that it currently is not being built as a module by anyone.
> Lets remove all modular references, so that when reading the driver
> there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> Cc: Brian Norris <computersforpeace@gmail.com>
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Gregory Fong <gregory.0xf0@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to drivers/next, thanks Paul
--
Florian
