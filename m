From: mporter@ti.com (Matt Porter)
Date: Wed, 10 Oct 2012 10:00:27 -0400
Subject: [PATCH] ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode
In-Reply-To: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
References: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20121010140027.GB13724@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 02:27:20PM +0530, Vaibhav Hiremath wrote:
> With recent changes in omap gpmc driver code, in case of DT
> boot mode, where bootloader does not configure gpmc cs space
> will result into kernel BUG() inside gpmc_mem_init() function,
> as gpmc cs0 gpmc_config7[0].csvalid bit is set to '1' and
> gpmc_config7[0].baseaddress is set to '0' on reset.
> 
> This use-case is applicable for any board/EVM which doesn't have
> any peripheral connected to gpmc cs0, for example BeagleXM and
> BeagleBone, so DT boot mode fails.
> 
> This patch adds of_have_populated_dt() check before creating
> device, so that for DT boot mode, gpmc probe will not be called
> which is expected behavior, as gpmc is not supported yet from DT.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Afzal Mohammed <afzal@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc Paul Walmsley <paul@pwsan.com>
> ---
> This should go in for rc1, as this breaks AM33xx boot.

Fixes BeagleBone on mainline.

Tested-by: Matt Porter <mporter@ti.com>

-Matt
