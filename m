From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 12:37:19 +0100
Subject: [PATCH 1/9] regulator: twl: Remove hardcoded board constraints
	from driver
In-Reply-To: <1317118372-17052-2-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-2-git-send-email-rnayak@ti.com>
Message-ID: <20110927113719.GH2910@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:42:44PM +0530, Rajendra Nayak wrote:
> Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
> each regulator from the twl driver and let the boards pass it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>


> -	/* Constrain board-specific capabilities according to what
> -	 * this driver and the chip itself can actually do.
> -	 */
> -	c = &initdata->constraints;
> -	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
> -	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
> -				| REGULATOR_CHANGE_MODE
> -				| REGULATOR_CHANGE_STATUS;

This isn't actually hard coding constraints, this is restricting the
constraints passed in further rather than adding new ones.

However should be fine:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
