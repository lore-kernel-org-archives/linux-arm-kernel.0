From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Sep 2011 14:50:51 +0100
Subject: [RFC PATCH 06/11] DT: regulator: Helper routine to extract
	fixed_voltage_config
In-Reply-To: <1316085727-15023-7-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
Message-ID: <20110915135051.GL7988@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:52:02PM +0530, Rajendra Nayak wrote:

>  .../devicetree/bindings/regulator/regulator.txt    |   19 ++++++++++++
>  drivers/of/of_regulator.c                          |   31 ++++++++++++++++++++
>  include/linux/of_regulator.h                       |    7 ++++
>  3 files changed, 57 insertions(+), 0 deletions(-)

Again, this should be part of the regulator API code not hidden away
where it will only get reviewed by device tree people.

>  Required properties:
>  - compatible: Must be "regulator";
> +or
> +- compatible: Must be "regulator-fixed"; /* For Fixed volatge regulator */

This seems at best confusing - the fixed voltage regulator is a
particular regulator driver, and the general concept of a fixed voltage
regulator is still a subset of regulators.

> +# For fixed voltage regulators
> +- supply-name: Name of the regulator supply
> +- microvolts: Output voltage of regulator
> +- gpio: gpio to use for enable control
> +- startup-delay: startup time in microseconds
> +- enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
> +- enabled-at-boot: 1 = yes, 0 = no

Much of this is specific to the Linux fixed voltage regulator driver
rather than a generic regulator with a fixed voltage.
