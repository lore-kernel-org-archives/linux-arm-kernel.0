From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 01 Jan 2013 14:40:50 +0200
Subject: [PATCH Resend] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <50E1FDCE.4010101@newsguy.com>
References: <1356728815-14410-1-git-send-email-mikedunn@newsguy.com>
 <50E1613B.9040403@compulab.co.il> <50E1FDCE.4010101@newsguy.com>
Message-ID: <50E2D952.2050201@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/12 23:04, Mike Dunn wrote:
> On 12/31/2012 01:56 AM, Igor Grinberg wrote:
>> On 12/28/12 23:06, Mike Dunn wrote:

[...]

>> How about one of the below:
>> 1)
>> GPIO113_GPIO | MFP_PULL_HIGH,
>> GPIO95_GPIO  | MFP_PULL_HIGH,
>>
>> or
>>
>> 2) introduce something like:
>> GPIO113_AC97_nRESET_GPIO_HIGH
>> GPIO95_AC97_nRESET_GPIO_HIGH
>> in the mfp-pxa27x.h file and use them in the structure above.
> 
> 
> OK, will implement your suggestion and resubmit.  To me, your first option seems
> clearer to the casual reader.

Actually, the second option is more robust, because you actually drive the pin.

-- 
Regards,
Igor.
