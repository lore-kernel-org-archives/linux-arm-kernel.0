From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 13 Jun 2017 19:33:28 +0900
Subject: [PATCH] drm/exynos/dsi: Remove error handling for bridge_node
 DT parsing
In-Reply-To: <593FAF9E.1040406@samsung.com>
References: <CGME20170609092307epcas5p3a7851f80bd799626782941a640824521@epcas5p3.samsung.com>
 <1497000180-30669-1-git-send-email-hoegeun.kwon@samsung.com>
 <593FAF9E.1040406@samsung.com>
Message-ID: <099ebbf8-4ec2-be45-f1d7-36bf24def429@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2017 06:25 PM, Inki Dae wrote:
>
> 2017? 06? 09? 18:23? Hoegeun Kwon ?(?) ? ?:
>> The bridge_node is unnecessary between FIMD and DSIM. If don't remove
>> error handling, it will not work between FIMD and DSIM. So remove
>> error handling.
> Please make sure to describe why bridge_node is unnecessary.
> For example,
> In case of Exynos SoC, a bridge device such as mDNIe and MIC could be placed between Display Controller and MIPI DSI device but the bridge device is required optionally.
>
> Thanks,
> Inki Dae

Remove the error handling for bridge_node because the bridge_node is
required optionally. It has already been described in commit message.

For example,
In case of Exynos 3250 SoC, no bridge_node is required between FIMD
and MIPI DSI.

Best regards,
Hoegeun

>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> ---
>>   drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> index a11b795..6ee0dac 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> @@ -1651,8 +1651,6 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>>   		return ret;
>>   
>>   	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>> -	if (!dsi->bridge_node)
>> -		return -EINVAL;
>>   
>>   	return 0;
>>   }
>>
>
