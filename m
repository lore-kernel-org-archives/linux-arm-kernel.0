From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Dec 2009 04:39:59 -0500
Subject: [PATCH 4/4] regulator: add max8925 support
In-Reply-To: <1261418546.6971.343.camel@odin>
References: <771cded00912210447jf040fd8s8da0e68db0c39c1a@mail.gmail.com>
	<1261418546.6971.343.camel@odin>
Message-ID: <771cded00912230139g23ea8554l866d55e16ae3ed58@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2009 at 1:02 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Mon, 2009-12-21 at 07:47 -0500, Haojian Zhuang wrote:
>> >From a895458d62d28060abc60db25f6d3782edd6b7a1 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Fri, 18 Dec 2009 10:02:16 -0500
>> Subject: [PATCH] regulator: add max8925 support
>>
>> MAX8925 contains 3 Buck and 20 LDO regulator.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> Had a quick look, some minor issues below.
>
>> +#define SD1_DVM_STEP ? ? ? ? (50000)
>> +#define SD1_DVM_SHIFT ? ? ? ? ? ? ? ?(5) ? ? ? ? ? ? /* SDCTL1 bit5 */
>> +#define SD1_DVM_EN ? ? ? ? ? (6) ? ? ? ? ? ? /* SDV1 bit 6 */
>
> Don't need parenthesis here.
>
>> + ? ? return (info->min_uV + index * info->step_uV);
>
> extra () here too.
>
>> +
>> + ? ? if ((uV < SD1_DVM_VMIN) || (uV > SD1_DVM_VMAX))
>> + ? ? ? ? ? ? return -EINVAL;
>
> and extra () here
>
>> + ? ? .vol_reg ? ? ? ?= MAX8925_SDV##_id, ? ? ? ? ? ? ? ? ? ? \
>> + ? ? .vol_shift ? ? ?= (0), ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>
> () not needed here and a few more below
>

Updated th patch.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-regulator-add-max8925-support.patch
Type: text/x-patch
Size: 11633 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091223/58e8beb3/attachment-0001.bin>
