From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 12 Feb 2018 13:32:20 +0530
Subject: [PATCH] ARM: da8xx: use platform data for CFGCHIP syscon regmap
In-Reply-To: <92c5a905-a3d3-1fcc-ff76-66ec075fbadc@ti.com>
References: <1516750563-24981-1-git-send-email-david@lechnology.com>
 <0ca5c498-e16e-f02a-28be-51ee9abb3363@ti.com>
 <92c5a905-a3d3-1fcc-ff76-66ec075fbadc@ti.com>
Message-ID: <76797622-733f-fe00-4a15-46a5f867a186@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 12 February 2018 01:26 PM, Sekhar Nori wrote:
> On Thursday 25 January 2018 08:57 PM, Sekhar Nori wrote:
>> + Arnd, Kishon and Lee for their information.
>>
>> On Wednesday 24 January 2018 05:06 AM, David Lechner wrote:
>>> This converts from using a platform device for the CFGCHIP syscon
>>> regmap to using platform data to pass the regmap to consumers.
>>>
>>> A lazy getter function is used so that the regmap will only be
>>> created if it is actually used. This function will also be used
>>> in the clock init when we convert to the common clock framework.
>>>
>>> The USB PHY driver is currently the only consumer. This driver is
>>> updated to use platform data to get the CFGCHIP regmap instead of
>>> syscon_regmap_lookup_by_pdevname().
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>
>>> This is based on the feedback from the series "ARM: davinci: common clock prep
>>> work?". https://lkml.org/lkml/2018/1/19/715
>>
>> It will be nice to have the discussion link as part of commit description.
>>
>> Links:
>> https://lkml.kernel.org/r/<CAK8P3a1AP1sz3nT8S6WMupo3iSVRsn2t9sPg2Mj1RAY1AS58UQ@mail.gmail.com>
>>
>> Kishon,
>>
>> With your ack I would like to queue this through the DaVinci tree for
> 
> Kishon, ping on this.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>> v4.17. Due to ongoing common clock framework conversion effort, I expect
>> to queue a number of other patches dependent on this.
>>
>> Once v4.16-rc1 comes out, I can provide an immutable commit/tag with
>> just this patch applied. You can use that if you end up queuing other
>> patches which conflict with this.
>>
>> Let me know.
> 
> Thanks,
> Sekhar
> 
