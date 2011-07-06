From: padma.kvr@gmail.com (padma venkat)
Date: Wed, 6 Jul 2011 13:08:40 +0530
Subject: [PATCH 2/2] SPI: S5PV210: Enable the SPI driver for S5PV210
In-Reply-To: <4E13D362.7010107@linaro.org>
References: <1309801476-29678-1-git-send-email-padma.v@samsung.com>
	<1309801476-29678-2-git-send-email-padma.v@samsung.com>
	<4E13D362.7010107@linaro.org>
Message-ID: <CAAgF-Bf8X8zoVn=UaQx-b4neinTJcHNr92F7q3nFdyyEo4kgOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On Wed, Jul 6, 2011 at 8:45 AM, Tushar Behera <tushar.behera@linaro.org> wrote:
> Hi,
>
> Patch 1/2 looks redundant as both changes can be very well accommodated in a
> single patch.
I thought it would be better to have seperate patch for two different
SoCs. So I made
the patches like that.

Hi Kukjin,

Please comment on this. Shall I make a single patch for both of the SoCs?

>
> On Monday 04 July 2011 11:14 PM, Padmavathi Venna wrote:
>>
>> The SPI module on S5PV210 is similar to the earlier Samsung SoCs like
>> S3C64XX. Enable the existing SPI driver for use on S5PV210.
>>
>> Signed-off-by: Padmavathi Venna<padma.v@samsung.com>
>> ---
>> ?drivers/spi/Kconfig | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 91d607b..ed1ebea 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -340,7 +340,8 @@ config SPI_S3C24XX_GPIO
>>
>> ?config SPI_S3C64XX
>> ? ? ? ?tristate "Samsung S3C64XX series type SPI"
>> - ? ? ? depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_S5PC100)
>> + ? ? ? depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_S5PC100 \
>> + ? ? ? ? ? ? ? ? ? ? ? || ARCH_S5PV210)
>> ? ? ? ?select S3C64XX_DMA if ARCH_S3C64XX
>> ? ? ? ?help
>> ? ? ? ? ?SPI driver for Samsung S3C64XX and newer SoCs.
>
>
> --
> Tushar Behera
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
