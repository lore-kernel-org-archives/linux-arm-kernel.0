From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 05 Aug 2010 10:35:31 +0300
Subject: [PATCH 1/3 v2] [ARM] pxa3xx: Add U2D controller and ULPI driver
In-Reply-To: <AANLkTimkijjQ7rykheOxnJmsmdVzx8Z+F+UbVh=q+MFb@mail.gmail.com>
References: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
	<1280232420-28691-2-git-send-email-grinberg@compulab.co.il>
	<AANLkTinBOH5J=DjhTsk9SS2YvANC9SZOzuEmdTO05wnF@mail.gmail.com>
	<4C5A57A5.6040702@compulab.co.il>
	<AANLkTimkijjQ7rykheOxnJmsmdVzx8Z+F+UbVh=q+MFb@mail.gmail.com>
Message-ID: <4C5A69C3.2030502@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/05/10 09:21, Eric Miao wrote:
> On Thu, Aug 5, 2010 at 2:18 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>   
>> On 08/05/10 08:47, Eric Miao wrote:
>>     
>>> On Tue, Jul 27, 2010 at 8:06 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>
>>>       
>>>> USB2.0 Device Controller (U2DC) which is found in Marvell PXA3xx.
>>>> U2DC supports both High and Full speed modes.
>>>> PXA320 and PXA300 U2DC supports only UTMI interface.
>>>> PXA310 U2DC supports only ULPI interface and has the OTG capability.
>>>>
>>>> U2D Controller ULPI driver introduced in this patch supports only the
>>>> PXA310 USB Host via the ULPI.
>>>>
>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>>>
>>>>         
>>> It's generally OK, but I have the building errors below:
>>>
>>>   CC      arch/arm/mach-pxa/devices.o
>>> In file included from
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h:15,
>>>                  from
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/devices.c:9:
>>> /home/ycmiao/kernel/linux-2.6/include/linux/usb/ulpi.h:145: warning:
>>> 'struct otg_io_access_ops' declared inside parameter list
>>> /home/ycmiao/kernel/linux-2.6/include/linux/usb/ulpi.h:145: warning:
>>> its scope is only this definition or declaration, which is probably
>>> not what you want
>>> In file included from
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/devices.c:9:
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h:29:
>>> warning: 'struct usb_bus' declared inside parameter list
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h:31:
>>> warning: 'struct usb_bus' declared inside parameter list
>>>
>>>
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c: In
>>> function 'pxa310_start_otg_hc':
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:176:
>>> error: 'ULPI_IC_6PIN_SERIAL' undeclared (first use in this function)
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:176:
>>> error: (Each undeclared identifier is reported only once
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:176:
>>> error: for each function it appears in.)
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:178:
>>> error: 'ULPI_IC_3PIN_SERIAL' undeclared (first use in this function)
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c: In
>>> function 'pxa310_otg_init':
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:213:
>>> error: 'ULPI_OTG_DRVVBUS' undeclared (first use in this function)
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:217:
>>> error: 'ULPI_IC_6PIN_SERIAL' undeclared (first use in this function)
>>> /home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/pxa3xx-ulpi.c:219:
>>> error: 'ULPI_IC_3PIN_SERIAL' undeclared (first use in this function)
>>> make[2]: *** [arch/arm/mach-pxa/pxa3xx-ulpi.o] Error 1
>>> make[1]: *** [arch/arm/mach-pxa] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>>
>>>
>>>       
>> Well, I think it is because the unmet dependency.
>> In the cover letter, I wrote that this series depends on
>> "Generic ULPI driver extention" series, which in its turn
>> depends on:
>>
>> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> Date: Thu, 8 Jul 2010 14:03:01 +0530
>> Subject: USB: ulpi: fix compilation warning
>>
>> From: Eric B?nard <eric@eukrea.com>
>> Date: Thu, 15 Jul 2010 09:20:19 +0200
>> Subject: [PATCH v2] otg/ulpi.c : fix register write
>>
>> as stated in its cover letter.
>>
>> I think you've missed the "USB: ulpi: fix compilation warning" patch.
>> You can find it at Greg's:
>> http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=usb/usb-ulpi-fix-compilation-warning.patch
>>
>>     
> I'll try merge these in a second git pull to Russell, til the above
> branch is merged in Linus' tree.
>   

Ok. Thanks :)

-- 
Regards,
Igor.
