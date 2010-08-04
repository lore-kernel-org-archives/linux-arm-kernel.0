From: ben@simtec.co.uk (Ben Dooks)
Date: Wed, 04 Aug 2010 16:03:13 +0100
Subject: [PATCH v3 3/3] ARM: SAMSUNG: i2c/busses: Add HAVE_S3C2410_I2C
	option to include I2C for Samsung SoCs
In-Reply-To: <AANLkTikyOUyz+sNPgBvWU8FvYa8HvgRY4P2udhMY=eOw@mail.gmail.com>
References: <1280396565-21014-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTikyOUyz+sNPgBvWU8FvYa8HvgRY4P2udhMY=eOw@mail.gmail.com>
Message-ID: <4C598131.3050705@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/10 01:22, Kyungmin Park wrote:
> On Thu, Jul 29, 2010 at 6:42 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> From: Naveen Krishna Ch <ch.naveen@samsung.com>
>>
>> This patch adds HAVE_S3C2410_I2C to control inclusion of I2C bus driver
>> on Samsung SoCs and makes I2C bus driver dependency SoC specific instead
>> of machine specific. This will enalbe all machines using Samsung ARCH_S3C2410,
>> _S3C64XX, _S5P6440, _S5PC100, and _S5PV210 to select the I2C driver by default
> 
> What's the different from use PLAT_SAMSUNG?
> 
> config I2C_S3C2410
>         tristate "S3C2410 I2C Driver"
>         depends on PLAT_SAMSUNG
> 
> Please don't populate the Kconfigs.

For things that are pretty common among all the Samsung architectures
such as the i2c, rtc and serial ports that we use PLAT_SAMSUNG, as these
drivers tend to compile and do not go wrong when loaded onto newer
systems (either the device name is changed, so if there is no support
then the driver will not bind, or someone didn't change the name in the
soc support and it should only be a transitory bug during development).

I'm going to spend some time thinking about the current Kconfig setup
to see if there is any improvements can be done.

-- 
Ben
