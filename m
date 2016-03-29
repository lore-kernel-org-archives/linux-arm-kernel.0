From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 28 Mar 2016 18:24:28 -0700
Subject: [PATCH v2 1/5] phy: Rename phy-brcmstb-sata driver to
 phy-brcm-sata driver
In-Reply-To: <1459140510-5317-2-git-send-email-anup.patel@broadcom.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <1459140510-5317-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <56F9D94C.5060905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2016 21:48, Anup Patel a ?crit :
> Currently, we have a common SATA3 PHY driver for all Broadcom
> STB SoCs. This driver can be extended and re-used for Broadcom
> iProc SoCs having same SATA3 PHY.
> 
> This patch renames existing Broadcom STB SATA3 PHY driver to
> common Broadcom SATA3 PHY driver to share this PHY driver across
> Broadcom SoCs.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
[snip]
> +config PHY_BRCM_SATA
> +	tristate "Broadcom SATA PHY driver"
> +	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
> +	depends on OF
> +	select GENERIC_PHY
> +	default ARCH_BCM_IPROC

This could be a separate patch of its own, but I do not think it matters
that much.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
