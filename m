From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 18 Feb 2011 12:49:49 +0530
Subject: [PATCH v2 06/13] da850: pruss CAN board specific additions.
In-Reply-To: <4D5583CF.8010905@mvista.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-7-git-send-email-subhasish@mistralsolutions.com>
	<4D5583CF.8010905@mvista.com>
Message-ID: <22D5E56F60D24A7190AD7FEAD0EF75D2@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--------------------------------------------------
From: "Sergei Shtylyov" <sshtylyov@mvista.com>
Sent: Saturday, February 12, 2011 12:15 AM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Cc: <davinci-linux-open-source@linux.davincidsp.com>; 
<sachi@mistralsolutions.com>; "Russell King" <linux@arm.linux.org.uk>; 
"Kevin Hilman" <khilman@deeprootsystems.com>; <nsekhar@ti.com>; "open list" 
<linux-kernel@vger.kernel.org>; <m-watkins@ti.com>; 
<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 06/13] da850: pruss CAN board specific additions.

> Subhasish Ghosh wrote:
>
>> This patch adds the pruss CAN pin mux and registers the device
>> with the pruss mfd driver.
>
>> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-da850-evm.c 
>> b/arch/arm/mach-davinci/board-da850-evm.c
>> index 242d1ed..2ce5536 100644
>> --- a/arch/arm/mach-davinci/board-da850-evm.c
>> +++ b/arch/arm/mach-davinci/board-da850-evm.c
>> @@ -1053,8 +1053,43 @@ static __init int da850_evm_init_cpufreq(void)
> [...]
>>  static struct da8xx_pruss_devices pruss_devices[] = {
>> - {.dev_name = NULL,},
>> + {
>> + .dev_name = "da8xx_pruss_can",
>> + .pdata = &can_data,
>> + .pdata_size = sizeof(can_data),
>> + .setup = da850_evm_setup_pruss_can,
>> + },
>> + {
>> + .dev_name = NULL,
>> + },
>
>    No need to explicitly initialize to NULL.

SG -- ok, Will remove
>
> WBR, Sergei 
