From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 15 Aug 2010 12:13:52 +0300
Subject: [Openpxa-users] Colibri PXA320 Power management question
In-Reply-To: <AANLkTinifZkdFaCg_Bh1pUMd4+Un0xQ3Wu81jyNf-4MH@mail.gmail.com>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>	<201008140853.03174.marek.vasut@gmail.com>
	<AANLkTinifZkdFaCg_Bh1pUMd4+Un0xQ3Wu81jyNf-4MH@mail.gmail.com>
Message-ID: <4C67AFD0.4020304@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/10 05:06, Eric Miao wrote:
> On Sat, Aug 14, 2010 at 2:53 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>   
>> Dne ?t 12. srpna 2010 12:02:17 Yuri Ludkevich napsal(a):
>>     
>>> Hi there :)
>>>
>>> I have a question about power management of Colibri PXA320 module:
>>> I found that bits PVE and FVE in PVCR register are disabled,
>>> so at frequency change voltage will not change.
>>>
>>> If I turn on PVE and FVE with pxaregs tool - voltage changes just fine.
>>> Where are suitable place in the kernel for PVCR initialization?
>>>       
>> I believe kernel should handle all that. Eric CCed.
>>
>>     
> Yep. Some of the design doesn't use the built-in power I2C at all,
> they use some non-standard I2C power management IC. So this
> should be handled in kernel indeed. The currently problem is that
> we don't yet have a clean framework, some platforms are writing
> directly to these registers to configure, which should be avoided.
>   

If I recall correctly, the pxa3xx built-in power I2C control is designed
for use with 100% compatible PMIC chip and if for some reason
the hardware has another PMIC, which is not 100% compatible,
then the built-in control can do more harm then good.

I think we need a good and configurable DVFS driver to take care
of all the power management stuff.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   

-- 
Regards,
Igor.
