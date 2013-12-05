From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 04:38:04 +0100
Subject: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and its
 related head file
In-Reply-To: <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201312050438.05117.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013, Hanjun Guo wrote:
> +static unsigned int gsi_to_irq(unsigned int gsi)
> +{
> +       int irq = irq_create_mapping(NULL, gsi);
> +
> +       return irq;
> +}

I think this could use a comment regarding your plans for IRQ domains.

Do you expect that all ACPI systems would have only a single GIC IRQ
controller and a single domain, or do you plan to add irqdomain code
later?

	Arnd
