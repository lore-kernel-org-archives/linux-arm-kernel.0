From: augulis.darius@gmail.com (Darius Augulis)
Date: Mon, 18 Oct 2010 16:46:10 +0300
Subject: [PATCH 4/9] ARM: S3C64XX: add USB host support for mach-real6410
In-Reply-To: <04a601cb6ec9$db82dee0$92889ca0$%kim@samsung.com>
References: <20100929192354.25307.40197.stgit@darius-desktop>
	<20100929193346.25307.75373.stgit@darius-desktop>
	<04a601cb6ec9$db82dee0$92889ca0$%kim@samsung.com>
Message-ID: <AANLkTinWveichrhruhyphNfMaV05o2FgPJncejdDgfAo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 4:39 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Darius Augulis wrote:
>>
>> Add USB host device support for mach-real6410
>>
>> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
>> ---
>> ?arch/arm/mach-s3c64xx/Kconfig ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-s3c64xx/mach-real6410.c | ? ?1 +
>> ?2 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
>> index b706b80..c05ae12 100644
>> --- a/arch/arm/mach-s3c64xx/Kconfig
>> +++ b/arch/arm/mach-s3c64xx/Kconfig
>> @@ -109,6 +109,7 @@ config MACH_REAL6410
>> ? ? ? select S3C_DEV_NAND
>> ? ? ? select SAMSUNG_DEV_ADC
>> ? ? ? select SAMSUNG_DEV_TS
>> + ? ? select S3C_DEV_USB_HOST
>> ? ? ? help
>> ? ? ? ? Machine support for the CoreWind REAL6410
>>
>> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-
>> s3c64xx/mach-real6410.c
>> index bad6990..00e7d7e 100644
>> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
>> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
>> @@ -195,6 +195,7 @@ static struct platform_device *real6410_devices[]
>> __initdata = {
>> ? ? ? &s3c_device_nand,
>> ? ? ? &s3c_device_adc,
>> ? ? ? &s3c_device_ts,
>> + ? ? &s3c_device_ohci,
>> ?};
>>
>> ?static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
>
> No need any gpio configuration for it?

No, USB is powered by hardware at startup and does not need any other
gpio config.

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
