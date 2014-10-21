From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 21 Oct 2014 23:35:43 +0400
Subject: [PATCH 1/2] ARM: pxa: spitz: register spitz-audio device
In-Reply-To: <87d29l1h5p.fsf@free.fr>
References: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com>
 <87d29l1h5p.fsf@free.fr>
Message-ID: <CALT56yOzXrfMx7JdCOU3jUqbKV4EqTpVf4bg6c0doZCSAV-1Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2014-10-21 21:12 GMT+04:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
> Hi Dmitry,
>
>> Register spitz-audio device to be used by ASoC driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
>> index 840c3a4..a9f971f 100644
>> --- a/arch/arm/mach-pxa/spitz.c
>> +++ b/arch/arm/mach-pxa/spitz.c
>> @@ -924,6 +924,23 @@ static inline void spitz_i2c_init(void) {}
>>  #endif
>>
>>  /******************************************************************************
>> + * Audio devices
>> + ******************************************************************************/
>> +#if defined(CONFIG_SND_PXA2XX_SOC_SPITZ) || defined(SND_PXA2XX_SOC_SPITZ_MODULE)
>> +static struct platform_device spitz_audio_device = {
>> +     .name   = "spitz-audio",
>> +     .id     = -1,
>> +};
>> +
>> +static inline void spitz_audio_init(void)
>> +{
>> +     platform_device_register(&spitz_audio_device);
>> +}
>> +#else
>> +static inline void spitz_audio_init(void) {}
>> +#endif
>
> Couldn't you eliminate the "#if defined" line , and "#else ... #endif" ?
>
> I mean that spitz_audio_init() would always register the spitz_audio_device,
> regardless of the config. The config would build or not build the sound soc
> platform driver. Would that be alright for all your usecases ?

Yes, of course. I just tried to mimic the style of the rest of the file.

I will resubmit the patch shortly.

-- 
With best wishes
Dmitry
