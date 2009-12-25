From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 25 Dec 2009 00:27:16 -0500
Subject: [PATCH 4/4] regulator: add max8925 support
In-Reply-To: <20091223143016.GD14455@opensource.wolfsonmicro.com>
References: <771cded00912210447jf040fd8s8da0e68db0c39c1a@mail.gmail.com>
	<1261418546.6971.343.camel@odin>
	<771cded00912230139g23ea8554l866d55e16ae3ed58@mail.gmail.com>
	<20091223143016.GD14455@opensource.wolfsonmicro.com>
Message-ID: <771cded00912242127k1b74a330k7d033d5cefd2169a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 9:30 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 23, 2009 at 04:39:59AM -0500, Haojian Zhuang wrote:
>
>> +#define MAX8925_REGULATOR_DRIVER(_name) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> +{ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? .driver ? ? ? ? = { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? ? ? ? ? .name ? = "max8925-" #_name, ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? .owner ?= THIS_MODULE, ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? }, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? .probe ? ? ? ? ?= max8925_regulator_probe, ? ? ? ? ? ? ?\
>> + ? ? .remove ? ? ? ? = __devexit_p(max8925_regulator_remove),\
>> +}
>> +
>> +static struct platform_driver max8925_regulator_driver[] = {
>> + ? ? MAX8925_REGULATOR_DRIVER(sd1),
>> + ? ? MAX8925_REGULATOR_DRIVER(sd2),
>> + ? ? MAX8925_REGULATOR_DRIVER(sd3),
>> + ? ? MAX8925_REGULATOR_DRIVER(ldo1),
>> + ? ? MAX8925_REGULATOR_DRIVER(ldo2),
>
> Since these driver structures differ only in name there seems to be no
> need to define more than one for the bucks and one for the LDOs - the
> code in the driver doesn't actually seem to need it. ?The .id field of
> the driver structure can be set to give the device numbers.
>
>> +}
>> +module_init(max8925_regulator_init);
>
> subsys_initcall()
>
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
>> +MODULE_DESCRIPTION("Regulator Driver for Maxim 8925 PMIC");
>> +MODULE_ALIAS("platform:max8925-regulator");
>
> This MODULE_ALIAS won't actually work - the name doesn't match up with
> the names of the drivers or the devices.
>

Updated the serie of patches.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-enable-max8925.patch
Type: text/x-patch
Size: 17423 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091225/620afbdd/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-mfd-add-subdevs-in-max8925.patch
Type: text/x-patch
Size: 9233 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091225/620afbdd/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-backlight-enable-max8925-backlight.patch
Type: text/x-patch
Size: 7467 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091225/620afbdd/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-regulator-add-max8925-support.patch
Type: text/x-patch
Size: 10451 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091225/620afbdd/attachment-0007.bin>
