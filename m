From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jul 2012 14:41:18 -0600 (MDT)
Subject: [PATCH-V3] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
In-Reply-To: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
References: <1343214422-28718-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1207251438210.23542@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vaibhav,

On Wed, 25 Jul 2012, Vaibhav Hiremath wrote:

> This patch adds HWMOD data for all the peripherals of
> AM335X device and also hooks up to the existing OMAP framework.

Looks pretty good.  One question:

> +static struct omap_hwmod am33xx_ehrpwm0_hwmod = {
> +	.name		= "ehrpwm.0",

These IP blocks and the ECAP IP blocks have periods in their names.
The rest of the IP block named in the file don't use periods -- which
is also the style used by the rest of the OMAP SoCs.  Is there
some reason that these have periods in their names?


- Paul
