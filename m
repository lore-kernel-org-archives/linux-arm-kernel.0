From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 22 Aug 2012 21:43:48 -0700
Subject: [V4 3/4] power_supply: Enable battery-charger for 88pm860x
In-Reply-To: <20120823034815.GB16674@lizard>
References: <20120714081254.GD20018@lizard>
 <1343377636-16128-1-git-send-email-jtzhou@marvell.com>
 <20120823034815.GB16674@lizard>
Message-ID: <20120823044348.GA415@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 08:48:15PM -0700, Anton Vorontsov wrote:
[....]
> drivers/mfd/88pm860x-core.c:803:53: warning: incorrect type in assignment (different base types)
> drivers/mfd/88pm860x-core.c:803:53:    expected struct charger_regulator *charger_regulators
> drivers/mfd/88pm860x-core.c:803:53:    got struct regulator_bulk_data static [toplevel] *
> 
> They are minor, except for the last one. You seemed to use
> 'regulator_bulk_data' struct (just as charger manager documentation
> wrongly tells you, yup), but in real it should have been
> 'struct charger_regulator'. The only reason that it worked is
> because both 'supply' and 'regulator_name' struct members are the
> first in these structs. :-)

Oh, actually, I see that this is a result of extcon rework, so not
your fault at all.

Anton.
