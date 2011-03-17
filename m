From: khilman@ti.com (Kevin Hilman)
Date: Thu, 17 Mar 2011 13:02:45 -0700
Subject: [PATCH V3 11/19] OMAP3+: SR: fix cosmetic indentation
In-Reply-To: <alpine.DEB.1.10.1103171939171.2634@esdhcp041196.research.nokia.com>
	(Aaro Koskinen's message of "Thu, 17 Mar 2011 19:43:09 +0200 (EET)")
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-12-git-send-email-nm@ti.com> <874o718xyy.fsf@ti.com>
	<alpine.DEB.1.10.1103171939171.2634@esdhcp041196.research.nokia.com>
Message-ID: <87mxkt1pne.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Hi,
>
> On Thu, 17 Mar 2011, Kevin Hilman wrote:
>>
>> Thanks, queuing for 2.6.40.
>>
> [...]
>>
>>> -		iounmap(sr_info->base);
>>> -		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
>>> -		release_mem_region(mem->start, resource_size(mem));
>>> -		list_del(&sr_info->node);
>>> -		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>>> -			"interrupt handler. Smartreflex will"
>>> -			"not function as desired\n", __func__);
>>> -		kfree(name);
>>> -		kfree(sr_info);
>>> -		return ret;
>>> +	iounmap(sr_info->base);
>>> +	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
>>> +	release_mem_region(mem->start, resource_size(mem));
>>> +	list_del(&sr_info->node);
>>> +	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>>> +		"interrupt handler. Smartreflex will"
>>> +		"not function as desired\n", __func__);
>>> +	kfree(name);
>>> +	kfree(sr_info);
>>> +	return ret;
>
> Just FYI, this code is partly broken and probably need to be fixed in .39.

OK

> Some of those resources are also freed by omap_sr_probe() when
> sr_late_init() fails and that cannot be correct.

Got a patch around to fix that?  Sounds like something we should get
into the .39-rc cycle.

Kevin
