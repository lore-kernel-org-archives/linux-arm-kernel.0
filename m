From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Aug 2016 10:58:19 +0100
Subject: [RFC PATCH v3 5/8] firmware: Add legacy SCPI protocol driver
In-Reply-To: <9b1d633e-6215-23c5-6cc2-bc64d104aa0a@baylibre.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
 <1470738562-20026-6-git-send-email-narmstrong@baylibre.com>
 <cea12544-6dfd-55d4-7c85-68290c720515@arm.com>
 <9b1d633e-6215-23c5-6cc2-bc64d104aa0a@baylibre.com>
Message-ID: <23fef94e-cebf-06c6-9ed1-c6a1d26df7ad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 16/08/16 10:41, Neil Armstrong wrote:
> On 08/15/2016 03:35 PM, Sudeep Holla wrote:
>> Hi Neil,
>>
>> On 09/08/16 11:29, Neil Armstrong wrote:
>>> Add legacy protocol driver for an early published SCPI implementation
>>> by supporting old command indexes and structure.
>>> This driver also supports vendor messages and rockchip specific
>>> mailbox data structure for message passing to SCP.
>>>
>>
>
> Hi Sudeep,
>
>> Sorry for the delay but I expected some attempts to reduce the
>> duplication of code we have here. I really don't like the duplication of
>> the code. As I mentioned earlier it can be reduced. I see lot of scope
>> for that and I see that you made zero attempts since v2.
>
> Yes, this post is an intermediate RFC to show to rockchip guys how I
> could implement supportfor their vendor commands, the next RFC will
> certainly merge the two  drivers with minimal code duplication.
>

Ah sorry for the comment then, I didn't realize that. I missed those
discussions.

>>> +enum legacy_scpi_client_id {
>>> +    SCPI_CL_NONE,
>>> +    SCPI_CL_CLOCKS,
>>> +    SCPI_CL_DVFS,
>>> +    SCPI_CL_POWER,
>>> +    SCPI_CL_THERMAL,
>>> +    SCPI_MAX,
>>> +};
>>> +
>>
>> As I said before these values were introduced by me initially and I
>> reckon firmware doesn't depend on that. Have you really tested dropping
>> them ? This must go as they are useless and we now have tokens which are
>> much better.
>
> I am not sure, I'm currently waiting for Amlogic's SCPI FW specification to be sure
> these are not needed at all, in the meantime I will still implement them.
>

Just change and give it a spin on your board. The initial spec mentions
that the SCP should return this as is as sent by the requester. I
thought of this grouping initially and then found certain limitations
and went with token which is bit more useful compared to this after some
review.

>>
>> I will stop here and ask why can't you start with simple change like
>> below ? Then we can add or re-define the structures/enums when
>> absolutely needed. Please don't just copy the entire driver and make
>> changes where-ever needed or please try to adapt to the new driver and
>> try to deviate as less as required by the firmware.
>
> It will be done in RFC v4.
>

Cool, thanks. I will try to review ASAP, so that we can target v4.9

-- 
Regards,
Sudeep
