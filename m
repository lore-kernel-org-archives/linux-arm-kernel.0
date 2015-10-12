From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 12 Oct 2015 10:43:49 +0800
Subject: [PATCH v6 05/17] drm: bridge: analogix/dp: dynamic parse sync_pol
 & interlace & dynamic_range
In-Reply-To: <561B0385.1070704@samsung.com>
References: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
 <1444491961-26799-1-git-send-email-ykk@rock-chips.com>
 <561B00D4.9060302@rock-chips.com> <561B0385.1070704@samsung.com>
Message-ID: <561B1E65.1040806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/12/2015 08:49 AM, Krzysztof Kozlowski wrote:
> On 12.10.2015 09:37, Yakir Yang wrote:
>> Hi Krzysztof,
>>
>> On 10/10/2015 11:46 PM, Yakir Yang wrote:
>>> Both hsync/vsync polarity and interlace mode can be parsed from
>>> drm display mode, and dynamic_range and ycbcr_coeff can be judge
>>> by the video code.
>>>
>>> But presumably Exynos still relies on the DT properties, so take
>>> good use of mode_fixup() in to achieve the compatibility hacks.
>>>
>>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>>> ---
>>> Changes in v6: None
>> +    of_property_read_u32(dp_node, "hsync-active-high",
>> +                 &video->h_sync_polarity);
>> +    of_property_read_u32(dp_node, "vsync-active-high",
>> +                 &video->v_sync_polarity);
>> +    of_property_read_u32(dp_node, "interlaced",
>> +                 &video->interlaced);
>> +}
>>
>>
>> Sorry, forget to fix your previous comment here, would
>> remember to fix it to v7 version, wish v6 would collect
>> more comment/reviewed/ack.  :)
> Right.
>
> You can send a v7 of only this patch.
>
> In the same time I would prefer not to chain-reply next version of
> entire patchset to cover letter of previous version. It confuses me
> because v6 appears UNDER v4 so I can't really find v6. I see v4 at the
> top of my email list.

Okay, I wish this chain-reply would make people easy to find the
previous comments, but actually it is little mess now. I would give
up this way to send patchset  :)

> In the same time the patchset is quite big. Put the latest version (with
> this issue above fixed!) on some repo and link it in cover letter.

Yeah, it's quite big now, I would like to back the patchset to previous
format, like:

---> [PATCH v6 00/17] Cover letter
   |----> [PATCH v6 01/17]
   |----> [PATCH ......]
   |----> [PATCH v6 05/17]
      |----> [PATCH v7 05/17]
   |----> [PATCH ......]
   |----> [PATCH v6 17/17]

Is it right, and can resend the v6 to fix this chain-reply issue with
RESEND flag ([PATCH RESEND v6 ...]) ?

---> [PATCH RESEND v6 00/17] Cover letter
   |----> [PATCH RESEND v6 01/17]
   |----> [PATCH ......]
   |----> [PATCH RESEND v6 05/17]
      |----> [PATCH v7 05/17]
   |----> [PATCH ......]
   |----> [PATCH RESEND v6 17/17]


Thanks :-)
- Yakir

>
> Best regards,
> Krzysztof
>
>> Best regards,
>> - Yakir
>>
>>> Changes in v5:
>>> - Switch video timing type to "u32", so driver could use
>>> "of_property_read_u32"
>>>     to get the backword timing values. Krzysztof suggest me that driver
>>> could use
>>>     the "of_property_read_bool" to get backword timing values, but that
>>> interfacs
>>>     would modify the original drm_display_mode timing directly (whether
>>> those
>>>     properties exists or not).
>>>
>>> Changes in v4:
>>> - Provide backword compatibility with samsung. (Krzysztof)
>>>
>>> Changes in v3:
>>> - Dynamic parse video timing info from struct drm_display_mode and
>>>     struct drm_display_info. (Thierry)
>>>
>>> Changes in v2: None
>
>
>
