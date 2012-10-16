From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Oct 2012 14:36:01 +0900
Subject: [PATCH 04/10] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <1350337894-9744-4-git-send-email-anton.vorontsov@linaro.org>
References: <20121015214954.GA3352@lizard>
 <1350337894-9744-4-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <20121016053559.GE8670@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 02:51:28PM -0700, Anton Vorontsov wrote:
> The driver uses platform-specific mxc_set_irq_fiq() with the VIRQ cookie
> passed to it, so it's pretty clear that the driver is absolutely sure
> that the FIQ is routed via platform-specific IC, and that the cookie can
> be used to mask/unmask FIQs. So, let's switch to the genirq routines,
> since we're about to remove FIQ-specific variants.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
