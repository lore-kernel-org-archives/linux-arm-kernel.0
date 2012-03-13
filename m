From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 13 Mar 2012 13:45:24 +0530
Subject: [PATCH v3 1/2] mfd: add irq domain support for max8997 interrupts
In-Reply-To: <CAJuYYwTKMWgits6xd0UUvRPwr40NwJfO2HncUOW9J=EZbFs8=Q@mail.gmail.com>
References: <1330000688-11226-1-git-send-email-thomas.abraham@linaro.org>
 <1330000688-11226-2-git-send-email-thomas.abraham@linaro.org>
 <20120313032832.655983E07E4@localhost>
 <CAJuYYwTKMWgits6xd0UUvRPwr40NwJfO2HncUOW9J=EZbFs8=Q@mail.gmail.com>
Message-ID: <CAJuYYwSQ-HRBU31=nWyzwqEBxj9LeAMOLQQVcAdf89dO9U0-sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2012 11:35, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> On 13 March 2012 08:58, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Thu, 23 Feb 2012 18:08:07 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>>> Add irq domain support for max8997 interrupts. The reverse mapping method
>>> used is linear mapping since the sub-drivers of max8997 such as regulator
>>> and charger drivers can use the max8997 irq_domain to get the linux irq
>>> number for max8997 interrupts. All uses of irq_base in platform data and
>>> max8997 driver private data are removed.
>>>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>> ---
>>> ?arch/arm/mach-exynos/mach-nuri.c ? ?| ? ?4 --
>>> ?arch/arm/mach-exynos/mach-origen.c ?| ? ?1 -
>>> ?drivers/mfd/max8997-irq.c ? ? ? ? ? | ? 60 ++++++++++++++++++++--------------
>>> ?drivers/mfd/max8997.c ? ? ? ? ? ? ? | ? ?1 -
>>> ?include/linux/mfd/max8997-private.h | ? ?4 ++-
>>> ?include/linux/mfd/max8997.h ? ? ? ? | ? ?1 -
>>> ?6 files changed, 38 insertions(+), 33 deletions(-)

[...]

>>
>> Hahaha. ?The max8997_irqs table is kind of overdone when the group and mask values
>> can be arithmetically derived from the hwirq number..
>
> Yes, I agree. Each group could have maximum of 8 interrupts. Then,
> data->hwirq % 8 will be the group number and data->hwirq & 7 would be

Typo here. group number = data->hwirq >> 3 and mask = data->hwirq & 7.

Thanks,
Thomas.
