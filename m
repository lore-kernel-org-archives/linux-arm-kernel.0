From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Sep 2014 20:36:13 +0100
Subject: [PATCH v11 07/19] irqchip: gic: Add support for FIQ management
In-Reply-To: <1409662853-29313-8-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-8-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140902193613.GX30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 02:00:41PM +0100, Daniel Thompson wrote:
> +static void gic_enable_fiq(struct irq_data *d)
> +{
> +	gic_set_group_irq(d, 0);
> +}
> +
> +static void gic_disable_fiq(struct irq_data *d)
> +{
> +	gic_set_group_irq(d, 1);
> +}

I think both the above functions should also call gic_unmask_irq() and
gic_mask_irq() directly rather than looping through enable_irq()/
disable_irq().

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
