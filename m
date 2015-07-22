From: vigneshr@ti.com (Vignesh R)
Date: Wed, 22 Jul 2015 10:54:25 +0530
Subject: [PATCH v2 1/2] input: touchscreen: pixcir_i2c_ts: Add support
 for optional wakeup interrupt
In-Reply-To: <20150720062407.GA13092@dtor-ws>
References: <1437367814-27785-1-git-send-email-vigneshr@ti.com>
 <1437367814-27785-2-git-send-email-vigneshr@ti.com>
 <20150720060929.GW17550@atomide.com> <20150720062407.GA13092@dtor-ws>
Message-ID: <55AF2909.5090609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On 07/20/2015 11:54 AM, Dmitry Torokhov wrote:
> On Sun, Jul 19, 2015 at 11:09:30PM -0700, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [150719 21:53]:
>>> @@ -445,6 +443,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>>>  	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
>>>  		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
>>>  
>>> +	pdata->wakeirq = of_irq_get_byname(dev->of_node, "wakeupirq");
>>> +
>>>  	return pdata;
>>
>> What about handling -EPROVE_DEFER here? At least pinctrl-single can be
>> be a loadable module for the dedicated wakeirqs.
> 
> Right. I think we should only allow -ENODATA to continue and return
> error in all other cases.

-EINVAL will be returned if "interrupt-names" is not specified. I will
make execption for -ENODATA & -EINVAL, and return error in all other cases?

> 
> Also, I think "irq" suffix on name is redundant.

Ok, will drop "irq" suffix:

+		interrupt-names = "tsc", "wakeup";

> 
> Thanks.
> 

-- 
Regards
Vignesh
