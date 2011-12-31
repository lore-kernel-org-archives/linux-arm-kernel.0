From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Dec 2011 01:02:40 +0000
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <20111230110842.GE2414@b20223-02.ap.freescale.net>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <20111230103026.GA2766@opensource.wolfsonmicro.com>
 <20111230103830.GD2414@b20223-02.ap.freescale.net>
 <20111230104850.GE2766@opensource.wolfsonmicro.com>
 <20111230110842.GE2414@b20223-02.ap.freescale.net>
Message-ID: <20111231010240.GC5835@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 07:08:43PM +0800, Richard Zhao wrote:
> On Fri, Dec 30, 2011 at 10:48:50AM +0000, Mark Brown wrote:

> > It shouldn't actually be passing on the constraint setting the voltage
> > when it constructs the constraints.

> --- a/drivers/regulator/of_regulator.c
> +++ b/drivers/regulator/of_regulator.c
> @@ -34,9 +34,6 @@ static void of_get_regulation_constraints(struct device_node *np,
>         /* Voltage change possible? */
>         if (constraints->min_uV != constraints->max_uV)
>                 constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
> -       /* Only one voltage?  Then make sure it's set. */
> -       if (constraints->min_uV == constraints->max_uV)
> -               constraints->apply_uV = true;

No!  That's going to break *all* other users.
