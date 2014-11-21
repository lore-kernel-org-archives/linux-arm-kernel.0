From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 12:33:02 +0100
Subject: [PATCH arm-soc/next/soc] bus: brcmstb_gisb: resolve section
 mismatch
In-Reply-To: <1416507286-14083-1-git-send-email-f.fainelli@gmail.com>
References: <1416507286-14083-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <2543744.XWzdaCUefE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 10:14:46 Florian Fainelli wrote:
> _code in
> brcmstb_gisb_arb_probe() which now calls a function annotated with __init, so
> this one must also be annotated with __init.
> 
> In order to avoid introducing another section mismatch, call
> platform_driver_probe() manually and remove the .probe assignment from
> brcmstb_gisb_arb_driver, this is very similar to what
> drivers/pci/host/pci-imx6.c does since we basically have the same constraints
> here.
> 
> Fixes: f1bee783dd37 ("bus: brcmstb_gisb: register the fault code hook")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Arnd, Olof,
> 
> This patch resolves a section mismatch found in the arm-soc tree in the
> next/soc branch which merged my two previous GISB patches.
> 

Applied to next/drivers, thanks a lot!

	Arnd
