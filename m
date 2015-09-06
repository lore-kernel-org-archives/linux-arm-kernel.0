From: ykk@rock-chips.com (Yakir Yang)
Date: Sun, 06 Sep 2015 09:33:45 +0800
Subject: [PATCH v4 01/16] drm: exynos/dp: fix code style
In-Reply-To: <1441259878.12163.75.camel@perches.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>	
 <1441086399-24889-1-git-send-email-ykk@rock-chips.com>	
 <55E79297.3050203@samsung.com> <55E7D4E4.6070808@rock-chips.com>	
 <55E7D5EB.1060505@samsung.com> <55E7DBA7.90504@rock-chips.com>
 <1441259878.12163.75.camel@perches.com>
Message-ID: <55EB97F9.3010503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

? 09/03/2015 01:57 PM, Joe Perches ??:
> On Thu, 2015-09-03 at 13:33 +0800, Yakir Yang wrote:
> []
>>>>>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c
> []
>>>>>> @@ -155,24 +156,22 @@ static int exynos_dp_read_edid(struct
>>>>>> exynos_dp_device *dp)
>>>>>>             }
>>>>>>               exynos_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST,
>>>>>> -                    &test_vector);
>>>>>> +                          &test_vector);
>>>>>>             if (test_vector & DP_TEST_LINK_EDID_READ) {
>>>>>> -            exynos_dp_write_byte_to_dpcd(dp,
>>>>>> -                DP_TEST_EDID_CHECKSUM,
>>>>>> +            exynos_dp_write_byte_to_dpcd(
>>>>>> +                dp, DP_TEST_EDID_CHECKSUM,
>>>>>>                     edid[EDID_BLOCK_LENGTH + EDID_CHECKSUM]);
>>>>>> -            exynos_dp_write_byte_to_dpcd(dp,
>>>>>> -                DP_TEST_RESPONSE,
>>>>>> +            exynos_dp_write_byte_to_dpcd(
>>>>>> +                dp, DP_TEST_RESPONSE,
>>>>>>                     DP_TEST_EDID_CHECKSUM_WRITE);
>>>>> To me, missing argument after opening parenthesis, looks worse. I would
>>>>> prefer:
>>>>>
>>>>>               exynos_dp_write_byte_to_dpcd(dp,
>>>>>
>>>>> Why you moved the 'dp' argument to new line?
>>>> Hmm... Just like style tool indicate, no more warning after
>>>> that change.
>>>>
>>>> For now, I would like to follow the original style, just improved
>>>> some obvious style problem.  :-)
>>> What was the checkpatch warning that said 'dp' has to move to new line?
>>> I tried this and I don't see it.
>> checkpatch haven't remind me that put dp to new line would fix
>> this warning, this just come from my experiments. And I works,
>> no more warnings from checkpatch, so I toke this style.
> Checkpatch isn't a great arbiter of style.
> It's just a brainless tool.
>
> Always use your instead of anything brainless.
>
> If it were code I was writing, I'd ignore 80 columns warnings
> where appropriate.
>
> These are long function names and long macro defines, so it's
> inappropriate to use 80 columns as a guiding style.
>
> I'd write:
>
> 		exynos_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST, &test_vector);
> 		if (test_vector & DP_TEST_LINK_EDID_READ) {
> 			exynos_dp_write_byte_to_dpcd(dp, DP_TEST_EDID_CHECKSUM,
> 						     edid[EDID_BLOCK_LENGTH + EDID_CHECKSUM]);
> 			exynos_dp_write_byte_to_dpcd(dp, DP_TEST_RESPONSE,
> 						     DP_TEST_EDID_CHECKSUM_WRITE);
> 		}
>

So... just ignore the 80 columns warnings. Actually I prefer to
keep the original style in this case.

Thanks,
- Yakir
]
>
>
>
