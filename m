From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Jan 2013 19:17:44 +0100
Subject: [PATCH 1/6] arm: mvebu: Add support for local interrupt
In-Reply-To: <1358790842-2986-2-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130121191744.0a04b941@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

Just some minor nitpicks below.

On Mon, 21 Jan 2013 18:53:57 +0100, Gregory CLEMENT wrote:

> +	if (hw < ARMADA_370_XP_MAX_PER_CPU_IRQS) {
> +

Unneeded empty line.

> +		irq_set_percpu_devid(virq);
> +		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
> +					handle_percpu_devid_irq);
> +
> +	} else {
> +		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
> +					handle_level_irq);
> +	}

Braces useless since there is only one statement in the else.

> +		set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);

Incorrect indentation for this line.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
