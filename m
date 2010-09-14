From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 14 Sep 2010 09:05:17 +0100
Subject: [PATCH v4] ux500: add ab8500-regulators machine specific data
In-Reply-To: <1284375772-22589-1-git-send-email-sundar.iyer@stericsson.com>
References: <1284375772-22589-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20100914080517.GB423@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 04:32:52PM +0530, Sundar Iyer wrote:

> +	.constraints = {
> +		.name = "ab8500-vaux1",
> +		.min_uV = AB8500_VAUXN_LDO_MIN_VOLTAGE,
> +		.max_uV = AB8500_VAUXN_LDO_MAX_VOLTAGE,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
> +					REGULATOR_CHANGE_STATUS,

As I keep pointing out this looks a bit odd since there are no consumers
set up on the regulator and you've got a large number of regulators with
this same set of constraints.  However, this won't cause a problem
without any consumers so this should be OK.
