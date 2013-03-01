From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 1 Mar 2013 16:24:27 -0600
Subject: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
In-Reply-To: <CALF0-+Xb-+ByPWm7AHzOOtZaasHV9MXLKHixHsBi2PZ==h0GAw@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
 <CALF0-+Xb-+ByPWm7AHzOOtZaasHV9MXLKHixHsBi2PZ==h0GAw@mail.gmail.com>
Message-ID: <51312A9B.10704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/01/2013 03:25 PM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> [...]
>> +static int gpmc_probe_nor_child(struct platform_device *pdev,
>> +                               struct device_node *child)
>> +{
>> +       struct gpmc_settings gpmc_s;
>> +       struct gpmc_timings gpmc_t;
>> +       struct resource res;
>> +       unsigned long base;
>> +       int ret, cs;
>> +
>> +       if (of_property_read_u32(child, "reg", &cs) < 0) {
>> +               dev_err(&pdev->dev, "%s has no 'reg' property\n",
>> +                       child->full_name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       if (of_address_to_resource(child, 0, &res)) {
>> +               dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
>> +                       child->full_name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = gpmc_cs_request(cs, res.end - res.start, &base);
> 
> How about using resource_size() above?
> 
> BTW, I believe it's size = end - start + 1.

Thanks, yes I can update.

Cheers
Jon
