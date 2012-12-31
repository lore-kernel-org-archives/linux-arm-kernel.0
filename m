From: mikedunn@newsguy.com (Mike Dunn)
Date: Mon, 31 Dec 2012 13:04:14 -0800
Subject: [PATCH Resend] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <50E1613B.9040403@compulab.co.il>
References: <1356728815-14410-1-git-send-email-mikedunn@newsguy.com>
 <50E1613B.9040403@compulab.co.il>
Message-ID: <50E1FDCE.4010101@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2012 01:56 AM, Igor Grinberg wrote:
> On 12/28/12 23:06, Mike Dunn wrote:


[..]


>>
>>  static unsigned long ac97_reset_config[] = {
>> -	GPIO113_GPIO,
>> +	MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH),
>>  	GPIO113_AC97_nRESET,
>> -	GPIO95_GPIO,
>> +	MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH),
> 
> It was always discouraged to code the above directly.


Had a funny feeling about that when I coded it...  I should have heeded the
feeling instead of being hasty.


> How about one of the below:
> 1)
> GPIO113_GPIO | MFP_PULL_HIGH,
> GPIO95_GPIO  | MFP_PULL_HIGH,
> 
> or
> 
> 2) introduce something like:
> GPIO113_AC97_nRESET_GPIO_HIGH
> GPIO95_AC97_nRESET_GPIO_HIGH
> in the mfp-pxa27x.h file and use them in the structure above.


OK, will implement your suggestion and resubmit.  To me, your first option seems
clearer to the casual reader.

Thanks Igor,
Mike
