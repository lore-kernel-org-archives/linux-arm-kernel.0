From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Fri, 20 Nov 2009 11:46:39 +0200
Subject: RFC [PATCH 6/9] Added lpc32xx platform.h file
In-Reply-To: <e68bb3470911192317s1203ae5k750ec6372539e433@mail.gmail.com>
References: <AcppfmTfmIz4uGVTSkSZH3tsHS4cTw==>	<083DF309106F364B939360100EC290F804F54D560F@eu1rdcrdc1wx030.exi.nxp.com>
	<e68bb3470911192317s1203ae5k750ec6372539e433@mail.gmail.com>
Message-ID: <4B06657F.8010800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2009 09:17 AM, Wan ZongShun wrote:
> Hi Kevin,
>
> And, this patch could not be applied in my Linux 2.6.32-rc7, error
> occurs as following:
>
> zswan at zswan-laptop:~/git-2.6/linux-2.6$ patch -p1<  Added\ lpc32xx\
> platform.h\ file.eml
> patching file arch/arm/mach-lpc32xx/include/mach/platform.h
> patch: **** malformed patch at line 1063:  */
>
> why?
>

[...]

>> +/*
>> + * p3_mux_set, p3_mux_clr, p3_mux_state register defines
>> + */
>> +#define P3_GPO2_MAT10                  _BIT(2)
>> +#define P3_GPO6_PWM43                  _BIT(6)
>> +#define P3_GPO8_PWM42                  _BIT(8)
>> +#define P3_GPO9_PWM41                  _BIT(9)
>> +#define P3_GPO10_PWM36                 _BIT(10)
>> +#define P3_GPO12_PWM35                 _BIT(12)
>> +#define P3_GPO13_PWM34                 _BIT(13)
>> +#define P3_GPO15_PWM33                 _BIT(15)
>> +#define P3_GPO16_PWM32                 _BIT(16)
>> +#define P3_GPO18_PWM31                 _BIT(18)
>> +
>> +/*
>> + * SSP module register offsets
>>   */

because the + is missing...

>> +#define LSSP_CR0(x)                    (x + 0x00)
>> +#define LSSP_CR1(x)                    (x + 0x04)
>> +#define LSSP_DATA(x)                   (x + 0x08)
>> +#define LSSP_SR(x)                     (x + 0x0C)
>> +#define LSSP_CPSR(x)                   (x + 0x10)
>> +#define LSSP_IMSC(x)                   (x + 0x14)
>> +#define LSSP_ICR(x)                    (x + 0x20)
>> +
>> +#define LSSP_ICR_RORIC                 (1<<  0)
>> +#define LSSP_ICR_RTIC                  (1<<  1)
>> +#define LSSP_CR0_DSS(n)                        _SBF(0, (((n) - 1)&  0xF))
>> +#define LSSP_CR0_FRF_SPI               0x0
>> +#define LSSP_CR0_CPOL(n)               _SBF(6, ((n)&  0x01))
>> +#define LSSP_CR0_CPHA(n)               _SBF(7, ((n)&  0x01))
>> +#define LSSP_CR0_SCR(n)                        _SBF(8, ((n)&  0xFF))
>> +#define LSSP_CR1_SSP_ENABLE            (1<<  1)
>> +#define LSSP_CPSR_CPDVSR(n)            _SBF(0, (n)&  0xFE)
>> +#define LSSP_SR_RNE                    (1<<  2)
>> +
>> +#endif
>> --
>> 1.6.0.6
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
>
