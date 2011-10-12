From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Oct 2011 17:08:57 -0600
Subject: [PATCH v4 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <1318371375-4083-3-git-send-email-swarren@nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-3-git-send-email-swarren@nvidia.com>
Message-ID: <CACxGe6u2Ae=6Fso1NEGA1wymczRykBGs0XB=pt7j8XyKmy6b+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 4:16 PM, Stephen Warren <swarren@nvidia.com> wrote:
> v3: Make regs variable static. Remove empty init of tegra_gpio_banks.
>
> v2: Retrieve IRQ and memory addresses from resources instead of hard-
> coding them. Add back initialization of tegra_gpio_chip.of_node.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

One comment below however.

> @@ -333,28 +335,55 @@ static struct irq_chip tegra_gpio_irq_chip = {
> ?*/
> ?static struct lock_class_key gpio_lock_class;
>
> -static int __init tegra_gpio_init(void)
> +static int __init tegra_gpio_probe(struct platform_device *pdev)

__devinit because this is put in the .probe hook of the driver.

g.
