From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 16 May 2012 13:48:27 +0300
Subject: [PATCH v1 2/7] usb: chipidea: remove zero check of hw_ep_max
In-Reply-To: <20120516053248.GA22251@nchen-desktop>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-3-git-send-email-richard.zhao@freescale.com>
 <20120516053248.GA22251@nchen-desktop>
Message-ID: <87ehqkcsg4.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Tue, May 15, 2012 at 09:58:18PM +0800, Richard Zhao wrote:
>> It's 0 for host only device.
>> 
>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> ---
>>  drivers/usb/chipidea/core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>> index f568b8e..15e03b3 100644
>> --- a/drivers/usb/chipidea/core.c
>> +++ b/drivers/usb/chipidea/core.c
>> @@ -195,7 +195,7 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
>>  		ffs_nr(DCCPARAMS_DEN);
>>  	ci->hw_ep_max = reg * 2;   /* cache hw ENDPT_MAX */
>>  
>> -	if (ci->hw_ep_max == 0 || ci->hw_ep_max > ENDPT_MAX)
>> +	if (ci->hw_ep_max > ENDPT_MAX)
>>  		return -ENODEV;
> Can you move this get hw_ep_max code to udc.c? As hw_ep_max is only used
> for device driver. What do you think, Alex?

Yes, I think this needs to go to udc.c in the future.

Regards,
--
Alex
