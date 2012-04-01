From: rabin@rab.in (Rabin Vincent)
Date: Mon, 2 Apr 2012 01:09:27 +0530
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
Message-ID: <CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2012 at 00:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Apr 1, 2012 at 8:58 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>
>> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
>> index ebc1e86..5be3248 100644
>> --- a/drivers/mfd/db8500-prcmu.c
>> +++ b/drivers/mfd/db8500-prcmu.c
>> @@ -2788,6 +2788,7 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
>> ? ? ? ? ? ? ? ?.constraints = {
>> ? ? ? ? ? ? ? ? ? ? ? ?.name = "db8500-vape",
>> ? ? ? ? ? ? ? ? ? ? ? ?.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>> + ? ? ? ? ? ? ? ? ? ? ? .always_on = true,
>> ? ? ? ? ? ? ? ?},
>> ? ? ? ? ? ? ? ?.consumer_supplies = db8500_vape_consumers,
>> ? ? ? ? ? ? ? ?.num_consumer_supplies = ARRAY_SIZE(db8500_vape_consumers),
>
> Combined with the PL022 patch this causes a power regression since
> the PL022 is hereafter always on.

How can there be a "power regression" here?  This is the only user of
the vcore regulator, and, apart from the fact that its disable routine
only decrements an essentialy write-only variable, it is shared which
several devices which already never disable it.
