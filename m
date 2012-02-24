From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Feb 2012 14:01:10 +0000
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
In-Reply-To: <1330091765.4102.547.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
 <20120224132408.GF5450@opensource.wolfsonmicro.com>
 <1330091765.4102.547.camel@sokoban>
Message-ID: <20120224140109.GG5450@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 03:56:05PM +0200, Tero Kristo wrote:

> So, do you want me to also change the num_voltages value for the
> regulator from zero to be the same as max_uV, as we have this check
> within regulator/core:

>        if (!ops->list_voltage || selector >= rdev->desc->n_voltages)
>                 return -EINVAL;

> This will also potentially make some code to iterate over regulator
> voltages for ~1.5M times. I still don't think adding list_voltage for
> the SMPS regulators makes any sense, unless either the API for
> regulator_list_voltage is changed, or we change the control for these
> regulators completely from set_voltage() based to set_voltage_sel()
> based implementation.

Well, the important thing here is to fill in something useful for the
returned selector rather than just leaving it undefined.  Providing a
list_voltage() would be nice and make things more robust.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/61da7e25/attachment.sig>
