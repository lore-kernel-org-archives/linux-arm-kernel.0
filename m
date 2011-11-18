From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 18 Nov 2011 13:35:56 -0800
Subject: [PATCHv9 05/18] mfd: omap-prm: add driver skeleton
In-Reply-To: <1316781986-30642-6-git-send-email-t-kristo@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
 <1316781986-30642-6-git-send-email-t-kristo@ti.com>
Message-ID: <4EC6CFBC.3090502@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2011 05:46 AM, Tero Kristo wrote:
> This driver will eventually support OMAP soc PRM module features, e.g. PRCM
> chain interrupts and voltage processor / controller. This patch only adds
> basic skeleton for the driver that can be probed for omap3 and omap4.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

> +config OMAP_PRM
> +	bool "OMAP Power and Reset Management driver"
> +	depends on (ARCH_OMAP) && PM

Minor: this should probably be

	default ARCH_OMAP && PM

So it's enabled by default whenever a PM kernel is built for OMAP.

Kevin
