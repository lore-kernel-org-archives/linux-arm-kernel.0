From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Aug 2012 15:57:03 +0100
Subject: [PATCH] ODROID-X: hkdk4412: Add new hardware based on Exynos4412
In-Reply-To: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
Message-ID: <20120806145702.GB29272@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 11:10:51PM +0900, Dongjin Kim wrote:

> +static struct regulator_consumer_supply __initdata max77686_buck4_consumer[] = {
> +	REGULATOR_SUPPLY("vdd_g3d", NULL),
> +};

Not that it matters much since new board drivers won't get merged but
all your regulator setup here is problematic.  These look like names
from the board schematic as opposed to mappings of the supplies onto the
consumer devices.

> +static struct regulator_init_data __initdata max77686_buck1_data = {
> +	.constraints = {
> +		.name		= "vdd_mif range",

This would normally just be the name of the supply for display purposes.
