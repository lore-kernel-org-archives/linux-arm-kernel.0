From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 19 Jan 2018 10:38:08 +0530
Subject: [PATCH v5 29/44] ARM: da8xx: add new USB PHY clock init using
 common clock framework
In-Reply-To: <c31d26b6-fb79-4581-039f-b977d737da2d@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-30-git-send-email-david@lechnology.com>
 <83dfab9a-be30-6313-d756-50fa018e757e@ti.com>
 <c31d26b6-fb79-4581-039f-b977d737da2d@lechnology.com>
Message-ID: <e549631a-b969-a1d3-ff7e-91ef65c5621a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 January 2018 12:13 AM, David Lechner wrote:
> On 01/18/2018 09:14 AM, Sekhar Nori wrote:
>> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>>> +int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
>>> +{
>>> +??? struct regmap *cfgchip;
>>> +??? struct clk *usb0_psc_clk, *clk;
>>> +??? struct clk_hw *parent;
>>> +
>>> +??? cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
>>
>> Am I right in understanding that this API is only called for non-DT
>> boot? If yes, do we really need the lookup by compatible?
> 
> This code is used in DT boot until [PATCH v5 43/44] "ARM: da8xx-dt:
> switch to device tree clocks". So, yes it is needed temporarily to
> prevent breaking USB.

Alright, so this line should probably be dropped either as part of 43/44
or later.

Thanks,
Sekhar
