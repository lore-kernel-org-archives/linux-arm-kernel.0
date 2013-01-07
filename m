From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 07 Jan 2013 17:41:57 +0200
Subject: [PATCH 4/4] ALSA: pxa27x: rename pxa27x_assert_ac97()
In-Reply-To: <50EADCF9.10307@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-5-git-send-email-mikedunn@newsguy.com>
 <50EA97EA.4030807@compulab.co.il> <50EADCF9.10307@newsguy.com>
Message-ID: <50EAECC5.4030700@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/13 16:34, Mike Dunn wrote:
> On 01/07/2013 01:39 AM, Igor Grinberg wrote:
>>
>>
>> On 01/06/13 21:14, Mike Dunn wrote:
>>> This patch does nothing functionally, it just gives the function a new name and
>>> modifies the prototype slightly in order to clarify what the function is doing
>>> (which is not necessarily asserting the reset).
>>> Some commentary also added.
>>>
>>> Tested on a palm treo 680 machine.
>>>
>>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>>
>> This patch makes sense, but again raising your concern...
>> The gpio_direction_output(reset_gpio, 1) should be called after
>> the change to AF0.
> 
> 
> Can you clarify please?  Don't you mean *before* the change to AF0?  The proper
> values must be set in the GPDR and GPSR/GPCR before changing to AF0, no?  This
> not only makes intuitive sense, it is also consistent with the information in
> the pxa270 developer's manual.  Once AF0 is set, the last values that were set
> for direction and level take immediate effect, no?

Yes, you are right, I've just forgot about the
#define GPIOx_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(...)
you introduced in patch 2, so no concern here. Sorry...


-- 
Regards,
Igor.
