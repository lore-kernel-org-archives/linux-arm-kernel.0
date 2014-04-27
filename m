From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Apr 2014 12:46:06 -0700
Subject: randconfig failures - MMC + trusted foundations
In-Reply-To: <20140427103302.GB26756@n2100.arm.linux.org.uk>
References: <20140427093250.GA26756@n2100.arm.linux.org.uk>
 <CAAVeFuJ2=fWamF6xBAJLv1kEEhBVgWMj-PY0gxouo6-NOE9OfQ@mail.gmail.com>
 <20140427103302.GB26756@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMhuMHnnHQ7fPFTHPX9Z2-T8MG7B-=CPOwCe=EFS232M=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 3:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Apr 27, 2014 at 07:09:31PM +0900, Alexandre Courbot wrote:
>> Hi Russell,
>>
>> On Sun, Apr 27, 2014 at 6:32 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Last night's versatile randconfig build:
>> >
>> > drivers/mmc/core/core.c: In function 'mmc_card_power_up':
>> > drivers/mmc/core/core.c:1517:4: error: implicit declaration of function 'gpiod_set_value'
>> >
>> > This one appears to be a regular feature of failure, and is as I'm
>> > carrying Olof's "mmc: add support for power-on sequencing through DT"
>> > patch for CuBox wireless - see the 222 patch set.  It probably points
>> > at something not being right with GPIO stuff.
>>
>> I had a quick look at the patch and I would say this is happening
>> because drivers/mmc/core/core.c does not include
>> <linux/gpio/consumer.h> despite using the gpiod_* functions. The error
>> will only happen if CONFIG_GPIOLIB is not defined. Olof, if it is not
>> too late can you fix this in your patch series?
>
> I received a report from someone else last week (in the mmc patch series
> I posted) that Chris has already merged this into his mmc tree, so I
> think it would need to be a follow on patch.

Huh, I don't see the patches in mmc-next. Did they get applied
somewhere else? They're not in linux-next either.

Timing is good though; I was hoping to revisit that patch set this week.


-Olof
