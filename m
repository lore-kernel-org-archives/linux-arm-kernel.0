From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jun 2017 17:52:19 +0200
Subject: [RFC PATCH v1] irqchip: Add support for tango interrupt router
In-Reply-To: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
Message-ID: <20170606175219.34ef62b9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 6 Jun 2017 15:42:36 +0200, Mason wrote:

> +	interrupt-controller at 6f800 {
> +		compatible = "sigma,smp8759-intc";
> +		reg = <0x6f800 0x430>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		/*
> +		 * There probably is a better way than explicitly listing
> +		 * the 24 interrupts?
> +		 */

What we do on Marvell platforms is:

	marvell,spi-base = <128>, <136>, <144>, <152>;

see marvell,odmi-controller.txt.

In another driver I submitted, we're doing:

	marvell,spi-ranges = <64 64>, <288 64>;

Retrospectively, I would have preferred to use marvell,spi-ranges for
the first DT binding as well, since it allows to express both the base
and number of interrupts available in the range.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
