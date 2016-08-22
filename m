From: John.Youn@synopsys.com (John Youn)
Date: Mon, 22 Aug 2016 15:08:19 -0700
Subject: [Bug] usb: dwc2: host function broken in OTG mode on bcm283x
In-Reply-To: <183575717.19886.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
References: <907297251.436328.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
 <785fc063-9b72-84a9-db91-c2710c19cdf9@synopsys.com>
 <183575717.19886.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
Message-ID: <37db5022-b98c-7f26-ca77-3ee9ba664edf@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2016 1:47 PM, Stefan Wahren wrote:
> Hi John,
> 
>> John Youn <John.Youn@synopsys.com> hat am 22. August 2016 um 22:06
>> geschrieben:
>>
>>
>> On 8/20/2016 6:03 AM, Stefan Wahren wrote:
>>> Hi John,
>>>
>>>
>>
>> Hi Stefan,
>>
>> Why doesn't DT work? I think all the properties are there to set
>> these.
> 
> it only works for the future releases, not for existing DT blobs. The DT is part
> of the ABI.
> 
> Yes, i already send a patch to fix the DT [1], but it would be better to fix the
> issue in deep.

I don't know much about DT issues. So I'm not sure what the issue is
with this. The properties for the gadget fifo sizes already exist so
there's no change to the ABI, correct?

Also, the patch you linked doesn't seem to have settings for the FIFO
sizes.

> 
>>
>> I hesitate to change the legacy/default settings in case it breaks any
>> existing drivers that depend on them.
> 
> Platforms? I didn't expected that other drivers use these settings.

Yes, I mean platforms.

I believe these values were hard-coded since before the unified "dwc2"
existed. So for sure there are platforms using these settings and to
lower them will negatively impact those platforms. The DT properties
were introduced to override these.

I think it is best to override them in the broken platforms. Either
that or fix it so that the defaults are more intelligently determined
in a way that maximizes the fifo sizes and cannot fail, as opposed to
some other arbitrary values.

> 
> Another option would be to add the gadget fifo sizes to platform data, but it's
> not a nice solution.

I agree, that wouldn't be good.

Regards,
John
