From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 28 Mar 2012 23:37:37 +0800
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <20120328152743.GW3232@opensource.wolfsonmicro.com>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
 <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
 <4F732C97.2030804@compulab.co.il>
 <20120328152743.GW3232@opensource.wolfsonmicro.com>
Message-ID: <CAN1soZy7jB_H0meVyh_H8nmbaSDmiDpjBYi_WO=pmjYzEf9r6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 11:27 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 28, 2012 at 05:21:59PM +0200, Igor Grinberg wrote:
>> On 03/09/12 00:06, Paul Gortmaker wrote:
>
>> > +REGULATOR_CONSUMER(ldo3, "reg-userspace-consumer", "vcc gps");
>
>> If you make this:
>> REGULATOR_CONSUMER(ldo3, NULL, "vcc gps");
>
>> > +REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer", "vcc gprs");
>>
>> and this:
>> REGULATOR_CONSUMER(ldo19, NULL, "vcc gprs");
>
> These don't look like good fixes, you should be specifying the
> dev_name() for the consumer device? ?Presumably it's two separate
> consumers and should be .0 and .1 or something?

Paul,

Could you do a quick update on dev_name() according to Mark's comment?

-REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
+REGULAOTR_CONSUMER(ldo10, dev_name(&pxa_device_mci.dev), "vcc sdio");

Best Regards
Haojian
