From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 9 Aug 2016 14:37:05 +0100
Subject: [PATCH 6/6] bus: Add support for Tegra Generic Memory Interface
In-Reply-To: <CALw8SCWjs2TnwFcTY=iXv_eskpKaKpvUmoXnTgtpoL8w9neD=w@mail.gmail.com>
References: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
 <1470512452-8322-7-git-send-email-mirza.krak@gmail.com>
 <fae8dbaf-53e9-dcfe-f755-32f7b28f4c9f@nvidia.com>
 <CALw8SCWjs2TnwFcTY=iXv_eskpKaKpvUmoXnTgtpoL8w9neD=w@mail.gmail.com>
Message-ID: <c6c6d000-d0d4-ac9f-e19e-0d2a513cd3e8@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/08/16 08:21, Mirza Krak wrote:
> 2016-08-08 15:47 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:

...

>>> +     return of_platform_default_populate(of_node, NULL, dev);
>>
>> Seems odd to do this here. Why not as the last thing in probe once the
>> GMI has been setup correctly?
> 
> It is done here mostly to avoid clean up in probe. I could move it out
> of tegra_gmi_parse_dt and put it right after that call but still
> before clk enable? Is that less odd?

I would have thought that clocks should be enabled and resets
de-asserted before we even attempt to populate any children. Hence, I
would do this last. Yes that will require some clean-up in probe if this
does fail but seems safest.

Cheers
Jon

-- 
nvpublic
