From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 17 Oct 2012 10:19:34 +0800
Subject: [PATCH v3 2/2] i2c: change id to let i2c-at91 work
In-Reply-To: <20121016111027.GE12801@game.jcrosoft.org>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
 <1350293428-24551-3-git-send-email-voice.shen@atmel.com>
 <20121015150244.GZ12801@game.jcrosoft.org> <507CD0CA.9010006@atmel.com>
 <20121016083954.GB12801@game.jcrosoft.org> <507D361C.6020403@atmel.com>
 <20121016111027.GE12801@game.jcrosoft.org>
Message-ID: <507E15B6.7040004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

On 10/16/2012 19:10, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:25 Tue 16 Oct     , Bo Shen wrote:
>> Hi J,
>>
>> On 10/16/2012 16:39, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 11:13 Tue 16 Oct     , Bo Shen wrote:
>>>> Hi J,
>>>>
>>>> On 10/15/2012 23:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> On 17:30 Mon 15 Oct     , Bo Shen wrote:
>>>>>> The i2c core driver will turn the platform device ID to busnum
>>>>>> When using platfrom device ID as -1, it means dynamically assigned
>>>>>> the busnum. When writing code, we need to make sure the busnum,
>>>>>> and call i2c_register_board_info(int busnum, ...) to register device
>>>>>> if using -1, we do not know the value of busnum
>>>>>> 	
>>>>>> In order to solve this issue, set the platform device ID as a fix number
>>>>>> Here using 0 to match the busnum used in i2c_regsiter_board_info()
>>>>>>
>>>>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>>>>> ---
>>>>>
>>>>> can you check when this append for the first time to schedule a patch for stable too
>>>>
>>>> OK. I will resend it and add linux stable into the cc list.
>>> no this not how it work
>>>
>>> I ask you to check which patch add the regression and then when this is
>>> applied in the kernel we will request greg to apply it too to the stable
>>
>> The code is using id = -1 appear 4 years ago. And after dig, I don't
>> find which patch cause this the regression.
> so use git bisect to find the commit responsible

Thanks for your information.

Finally, I found the following commit add this:

3267c077e589bc146a0b45e220fcefafbf83fb80
[ARM] 3396/2: AT91RM9200 Platform devices update

BRs,
Bo Shen

> Best Regards,
> J.
>
