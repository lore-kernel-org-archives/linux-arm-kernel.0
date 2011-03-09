From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 9 Mar 2011 09:59:04 +0530
Subject: [PATCH v3 3/7] da850: pruss board specific additions.
In-Reply-To: <4D7648FB.9080904@mvista.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-4-git-send-email-subhasish@mistralsolutions.com>
	<4D7648FB.9080904@mvista.com>
Message-ID: <54A69D4520F34B0ABD7EFF35DAEFC5DC@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

If I don't initialize it to NULL, its getting initialized to some garbage 
string.

--------------------------------------------------
From: "Sergei Shtylyov" <sshtylyov@mvista.com>
Sent: Tuesday, March 08, 2011 8:49 PM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Cc: <davinci-linux-open-source@linux.davincidsp.com>; 
<sachi@mistralsolutions.com>; "Russell King" <linux@arm.linux.org.uk>; "open 
list" <linux-kernel@vger.kernel.org>; <m-watkins@ti.com>; 
<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/7] da850: pruss board specific additions.

> Hello.
>
> On 08-03-2011 16:57, Subhasish Ghosh wrote:
>
>> This patch adds board specific initializations and setup routines.
>
>> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-da850-evm.c 
>> b/arch/arm/mach-davinci/board-da850-evm.c
>> index 11f986b..c614c82 100644
>> --- a/arch/arm/mach-davinci/board-da850-evm.c
>> +++ b/arch/arm/mach-davinci/board-da850-evm.c
>> @@ -1053,6 +1053,26 @@ static __init int da850_evm_init_cpufreq(void)
>>   static __init int da850_evm_init_cpufreq(void) { return 0; }
>>   #endif
>>
>> +static struct da8xx_pruss_devices pruss_devices[] = {
>> + {.dev_name = NULL,},
>
>    No need to explictly intialize to NULL.
>
> WBR, Sergei 
