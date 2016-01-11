From: Annie.Wang@amd.com (Wang, Annie)
Date: Mon, 11 Jan 2016 07:26:39 +0000
Subject: [PATCH 1/6] 8250/Kconfig: add config option CONFIG_SERIAL_8250_AMD
In-Reply-To: <20160106104602.GA19507@pd.tnic>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
 <1451885501-2710-2-git-send-email-annie.wang@amd.com>
 <20160104144118.GJ22941@pd.tnic>
 <BLUPR12MB0433ABAC5C5D27D3FD0F4BF381F40@BLUPR12MB0433.namprd12.prod.outlook.com>
 <20160106104602.GA19507@pd.tnic>
Message-ID: <BLUPR12MB043368006316A2FB11A0DE8B81C90@BLUPR12MB0433.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Borislav Petkov [mailto:bp at alien8.de]
>Sent: Wednesday, January 06, 2016 6:46 PM
>To: Wang, Annie
>Cc: Andy Shevchenko; Vinod Koul; Mika Westerberg; Greg Kroah-Hartman; Rafael
>J. Wysocki; linux-acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
>serial at vger.kernel.org; dmaengine at vger.kernel.org; Huang, Ray; Wan, Vincent;
>Xue, Ken; Robin Murphy; Graeme Gregory; Li, Tony; Yu, Xiangliang
>Subject: Re: [PATCH 1/6] 8250/Kconfig: add config option
>CONFIG_SERIAL_8250_AMD
>
>On Wed, Jan 06, 2016 at 02:08:18AM +0000, Wang, Annie wrote:
>> How about I add select ARM_AMBA and SERIAL_8250 in arch/x86/Kconfig?
>
>Yeah, select sounds good in that case, except in that particular case ...
>
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
>> db3622f..0fe6657 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -537,11 +537,15 @@ config X86_AMD_PLATFORM_DEVICE
>>         depends on ACPI
>>         select COMMON_CLK
>>         select PINCTRL
>> +       select SERIAL_8250
>> +       select ARM_AMBA
>
>... that's a X86_AMD_PLATFORM_DEVICE which selects ARM thing? i.e.,
>ARM_AMBA. Can that even work?
>
>[ Rant on the side: And that ARM_AMBA thing has, of course, no effing
>  help text. Dammit, people need to start explaining those cryptic
>  abbreviations. Somewhere in the code I found "Advanced Microcontroller
>  Bus Architecture". This is clearly suboptimal. ]
>
>So why does the X86 platform device need to select the AMBA crap?


Russell, 

The AMBA bus is already leveraged  in AMD X86 arch hardware design for UART
controller and UART DMA. And may will be used in other arch as well, however,
it is rather confusing if we select ARM_AMBA in other arch, such as X86.

How about rename  CONFIG_ARM_AMBA to CONFIG_AMBA? So different arch
can select it without causing misunderstanding. 

Thank you very much.
Regards,
Hongcheng(Annie)
