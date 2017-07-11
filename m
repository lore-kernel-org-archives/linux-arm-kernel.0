From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 11 Jul 2017 08:44:54 +0800
Subject: [PATCH] drm/rockchip: fix NULL check on devm_kzalloc() return
 value
In-Reply-To: <20170710190452.6nzd4tihronl5m5n@art_vandelay>
References: <20170706215833.GA25411@embeddedgus>
 <595EDC3C.1010801@rock-chips.com>
 <20170710190452.6nzd4tihronl5m5n@art_vandelay>
Message-ID: <59641F86.4010902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?07?11? 03:04, Sean Paul wrote:
> On Fri, Jul 07, 2017 at 08:56:28AM +0800, Mark yao wrote:
>> On 2017?07?07? 05:58, Gustavo A. R. Silva wrote:
>>> The right variable to check here is port, not dp.
>>>
>>> This issue was detected using Coccinelle and the following semantic patch:
>>>
>>> @@
>>> expression x;
>>> identifier fld;
>>> @@
>>>
>>> * x = devm_kzalloc(...);
>>>     ... when != x == NULL
>>>     x->fld
>>>
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> Thanks for the fix,
>>
>> Acked-by: Mark Yao <mark.yao@rock-chips.com>
> Hi Mark,
> I've applied this patch, but in the future, please apply changes directly
> instead of just acking.
>
> If you're unable to apply it for some reason (vacation, etc), please reach out to
> one of the -misc maintainers via email or irc so we don't inadvertently lose track
> of it on the list.
>
> Sean
Hi Sean

Got it,  I  will do it right next time.
Thanks to inform me this,

>
>>> ---
>>>    drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>> index 14fa1f8..9b0b058 100644
>>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
>>> @@ -1195,7 +1195,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
>>>    			continue;
>>>    		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>> -		if (!dp)
>>> +		if (!port)
>>>    			return -ENOMEM;
>>>    		port->extcon = extcon;
>>
>> -- 
>> ?ark Yao
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
?ark Yao
