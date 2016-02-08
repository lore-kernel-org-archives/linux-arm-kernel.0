From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 08 Feb 2016 13:38:11 +0100
Subject: [PATCH] drm/exynos: dp: Fix panel and bridge lookup logic
In-Reply-To: <56B88418.7090106@osg.samsung.com>
References: <1454080171-23769-1-git-send-email-javier@osg.samsung.com>
 <56B88418.7090106@osg.samsung.com>
Message-ID: <56B88C33.8060808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 2016-02-08 13:03, Javier Martinez Canillas wrote:
> Hello Inki,
>
> On 01/29/2016 12:09 PM, Javier Martinez Canillas wrote:
>> Commit a9fa852886fd ("drm/exynos: dp: add of_graph dt binding support
>> for panel") made the Exynos DP DT binding more consistent since the OF
>> graph could be used to lookup either a panel or a bridge device node.
>>
>> Before that commit, a panel would be looked up using a phandle and a
>> bridge using the OF graph which made the DT binding not consistent.
>>
>> But the patch broke the later case since not finding a panel dev node
>> would cause the driver's to do a probe deferral instead of attempting
>> to lookup a bridge device node associated with the remote endpoint.
>>
>> So instead of returning a -EPROBE_DEFER if a panel is not found, check
>> if there's a bridge and only do a probe deferral if both aren't found.
>>
>> Fixes: a9fa852886fd ("drm/exynos: dp: add of_graph dt binding support 
>> for panel")
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>
> Any comments about this patch? It is needed to have display working on
> machines with a bridge chip again so it should be pushed to -rc ASAP.

Please check v4.5-rc3, this patch is already merged there.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
