From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 21 Jul 2010 23:02:22 +0900
Subject: [PATCH v2 3/3] i2c/busses: Select I2C bus support for S5PV210 and
	S5P6440.
In-Reply-To: <00a901cb28dc$75b5dc80$61219580$%kim@samsung.com>
References: <1279717167-24456-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTilygLmO9n0oconz73C6Bjtsgbh0cbfnJ1zU9YMb@mail.gmail.com>
	<00a901cb28dc$75b5dc80$61219580$%kim@samsung.com>
Message-ID: <AANLkTikV2oR5t9-xUxuJ_CHfMyJUWjdt-6AsoAUm5YqL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 10:55 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> I don't want to modify Kconfig anymore. it's simple to modify driver
> itself.
>>
> Yeah, I think so.
>
>> Think the usage of I2c. I think there's no case don't use it.
>>
>> At this time modify Kconfig once, and just fix the driver if new SoCs
>> are arrives.
>> Of course we can modify Kconfig one more, If there's really new IPs of
>> I2C are created. but I expect we also need to define new PLAT_SAMSUNG2
>>
> Maybe you did see the Watchdog driver...I think, in this case, the depending
> on 'HAVE_xxx_I2C' is better than 'PLAT_xxx'.
>
> If there is newer I2C, the 'HAVE_xxx_I2Cv2' is enough.

yes it's personal taste. I just don't want to modify each Kconfig for
every samsung ARCH.
Now your team enables Samsung SoCs peripherals and if you like this
way, you should define all SoCs peripherals like this.

>
>> Thank you,
>> Kyungmin Park
>>
>> On Wed, Jul 21, 2010 at 9:59 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > From: Naveen Krishna Ch <ch.naveen@samsung.com>
>> >
>> > This patch is to select support I2C channels 0, 1 and 2 for S5PV210 and
>> S5P6440.
>> >
>> > Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> > ---
>> > Changes since v1:
>> > - Modifed the Kconfig help comments.
>> >
>> > ?drivers/i2c/busses/Kconfig | ? ?6 +++---
>> > ?1 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> > index bceafbf..27c96ec 100644
>> > --- a/drivers/i2c/busses/Kconfig
>> > +++ b/drivers/i2c/busses/Kconfig
>> > @@ -523,10 +523,10 @@ config I2C_PXA_SLAVE
>> >
>> > ?config I2C_S3C2410
>> > ? ? ? ?tristate "S3C2410 I2C Driver"
>> > - ? ? ? depends on ARCH_S3C2410 || ARCH_S3C64XX
>> > + ? ? ? depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5P6440 ||
>> ARCH_S5PV210
>> > ? ? ? ?help
>> > - ? ? ? ? Say Y here to include support for I2C controller in the
>> > - ? ? ? ? Samsung S3C2410 based System-on-Chip devices.
>> > + ? ? ? ? Say Y here to include support for I2C controller in the
> Samsung
>> > + ? ? ? ? S3C2410, S3C64XX, S5P6440 and S5PV210 based System-on-Chip
>> devices.
>> >
>> > ?config I2C_S6000
>> > ? ? ? ?tristate "S6000 I2C support"
>> > --
>> > 1.6.2.5
>> >
>> > --
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
