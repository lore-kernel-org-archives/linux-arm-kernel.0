From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 6 Jan 2014 17:33:39 +0800
Subject: [PATCH v3] ARM: prima2: move to generic reset controller driver
 framework
In-Reply-To: <1389000455.5590.4.camel@pizza.hi.pengutronix.de>
References: <1388998927-9227-1-git-send-email-21cnbao@gmail.com>
 <1389000455.5590.4.camel@pizza.hi.pengutronix.de>
Message-ID: <CAGsJ_4wZnb0CLqv-CrJz1G3pXXcW=959L2AzjfTXys2Y_vsk-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/6 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Barry,
>
>> -
>> -int sirfsoc_reset_device(struct device *dev)
>> +static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
>> +                                     unsigned long sw_reset_idx)
>>  {
>> -     u32 reset_bit;
>> +     u32 reset_bit = sw_reset_idx;
>>
>> -     if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))
>
> It seems switching to the reset controller framework is an incompatible
> device tree change. I take it this is not an issue because the old
> binding was never documented / is not used in the wild?

yes. old binding was never documented and used before it was moved to
reset controller.

> If so, apart from a few whitespace issues, this looks good to me.

may i take this as an Ack from you?

sorry. i missed two tab issues and will fix in v4.

ERROR: code indent should use tabs where possible
#148: FILE: arch/arm/mach-prima2/common.c:20:
+        sirfsoc_of_rstc_init();$

ERROR: code indent should use tabs where possible
#149: FILE: arch/arm/mach-prima2/common.c:21:
+        of_platform_populate(NULL, of_default_bus_match_table,$

>
> regards
> Philipp
>

-barry
