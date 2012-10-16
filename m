From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 16 Oct 2012 11:13:14 +0800
Subject: [PATCH v3 2/2] i2c: change id to let i2c-at91 work
In-Reply-To: <20121015150244.GZ12801@game.jcrosoft.org>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
 <1350293428-24551-3-git-send-email-voice.shen@atmel.com>
 <20121015150244.GZ12801@game.jcrosoft.org>
Message-ID: <507CD0CA.9010006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

On 10/15/2012 23:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:30 Mon 15 Oct     , Bo Shen wrote:
>> The i2c core driver will turn the platform device ID to busnum
>> When using platfrom device ID as -1, it means dynamically assigned
>> the busnum. When writing code, we need to make sure the busnum,
>> and call i2c_register_board_info(int busnum, ...) to register device
>> if using -1, we do not know the value of busnum
>> 	
>> In order to solve this issue, set the platform device ID as a fix number
>> Here using 0 to match the busnum used in i2c_regsiter_board_info()
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>
> can you check when this append for the first time to schedule a patch for stable too

OK. I will resend it and add linux stable into the cc list.

Thanks.

BRs,
Bo Shen

> Best Regards,
> J.
>
