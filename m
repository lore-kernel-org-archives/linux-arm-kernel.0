From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Feb 2012 13:24:09 +0000
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
In-Reply-To: <1330089398.4102.539.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
Message-ID: <20120224132408.GF5450@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 03:16:38PM +0200, Tero Kristo wrote:

> I still ain't quite sure how this would work, do you mean adding
> something like this:

> +static int twl6030smps_list_voltage(struct regulator_dev *rdev,
> +                                   unsigned int selector)
> +{
> +       return selector;
> +}

Yes.

> I believe this would fail still. I took a look at a few drivers that use
> regulator_list_voltage(), but all of these seem to numerate voltages
> based on regulator_count_voltages(), which will return -EINVAL for the
> SMPS ones as the num_voltages is zero. Also, even if I defined
> num_voltages here, I would be attempting to list_voltage for zero index,
> returning zero, but this would be invalid voltage for the cpu obviously
> (and is also out of range for the regulator min_voltage, and also
> according to docs invalid return value for the function in the first
> place.)

Well, clearly some of the values won't actually be useful and you should
feel free to return error values for those or apply an offset or
something but the basic principle applies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/f044e41f/attachment.sig>
