From: lznuaa@gmail.com (Frank Li)
Date: Mon, 12 Nov 2012 09:56:47 +0800
Subject: [PATCH 1/1] regulator: gpio-regulator: fix crash when no states
 property in dt
In-Reply-To: <20121109165609.GV23807@opensource.wolfsonmicro.com>
References: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
 <20121109165609.GV23807@opensource.wolfsonmicro.com>
Message-ID: <CAHrpEqSbydeAHngL-NMfQa1HQUsj0US5u=aK6y-ku0DMOW-KkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Nov 09, 2012 at 04:34:36PM +0800, Frank Li wrote:
>
>>       /* Fetch states. */
>>       prop = of_find_property(np, "states", NULL);
>> -     proplen = prop->length / sizeof(int);
>> +     proplen = prop ? prop->length / sizeof(int) : 0;
>
> Aren't states mandatory for this driver, in which case shouldn't the
> probe fail here?

I think No.  GPIO-Regulator can be used as just turn on/off power
domain and not adjust voltage or current.  So "states" is option.
"gpios" was already options.
