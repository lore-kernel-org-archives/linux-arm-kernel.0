From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Mon, 21 Sep 2015 11:10:56 +0200
Subject: [PATCH v4 1/3] leds: netxbig: add device tree binding
In-Reply-To: <20150918131011.GN7306@kw.sim.vm.gnt>
References: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
 <1442505571-9744-2-git-send-email-simon.guinot@sequanux.org>
 <55FBD679.2020402@samsung.com> <20150918103006.GM7306@kw.sim.vm.gnt>
 <55FBEC38.6020209@samsung.com> <20150918131011.GN7306@kw.sim.vm.gnt>
Message-ID: <55FFC9A0.1020608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2015 03:10 PM, Simon Guinot wrote:
> On Fri, Sep 18, 2015 at 12:49:28PM +0200, Jacek Anaszewski wrote:
>>>>
>>>> Moreover, if you switched to using devm* prefixed version of
>>>> gpio_request_one and led_classdev_reqister, you could simplify
>>>> the error paths in the driver.
>>>
>>> Yes, I have a pending patch for this conversion. But since it is not
>>> really related with the subject of this patch series (add DT support),
>>> I was planning to send it next.
>>>
>>> Do you want me to include this patch into this series.
>>
>> Why not, if you have it ready to go. If it needs some polishing,
>> we can live with what we have now.
>
> No, the patch is ready. I'll add it.
>
>>>>> +static const struct of_device_id of_netxbig_leds_match[] = {
>>>>> +	{ .compatible = "lacie,netxbig-leds", },
>>>>> +	{},
>>>>> +};
>>>>> +#else
>>>>> +static int netxbig_leds_get_of_pdata(struct device *dev,
>>>>> +				     struct netxbig_led_platform_data *pdata)
>>>>
>>>> s/static int/static inline int/
>>>
>>> Is that not already the case with modern compiler ?
>>
>> Could you elaborate on this?
>
> There is not much to say. netxbig_leds_get_of_pdata is a single line of
> code. I am not a gcc expert but I am quite confident that this function
> will be inlined anyway (given the optimisation level used to compile the
> Linux kernel). That's it.
>
> But there is nothing wrong by adding "inline" neither.

Right. All the more, this is a common pattern for no-ops, also in *.c
files.


-- 
Best Regards,
Jacek Anaszewski
