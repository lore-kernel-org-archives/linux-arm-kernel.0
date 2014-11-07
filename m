From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 7 Nov 2014 19:13:49 +0200
Subject: [REPOST PATCH 1/2] ARM: OMAP3+: TWL: add support for mapping
 platform data via pdata-quirks
In-Reply-To: <20141107152201.GS8509@sirena.org.uk>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
 <1412949989-20186-2-git-send-email-t-kristo@ti.com>
 <20141107152201.GS8509@sirena.org.uk>
Message-ID: <545CFDCD.5090006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 05:22 PM, Mark Brown wrote:
> On Fri, Oct 10, 2014 at 05:06:28PM +0300, Tero Kristo wrote:
>
>> -	dev->platform_data = &twl_gpio_auxdata;
>> +	if (!strcmp("twl4030-gpio", dev_name(dev)))
>> +		dev->platform_data = &twl_gpio_auxdata;
>> +	else
>> +		dev->platform_data = omap_twl_match_regulator(dev);
>
> Looking at this idiom here I'd expect that we'd be adding another string
> comparison here?

We are actually doing an of_match_node call within the 
twl_match_regulator. However, we had a short offline discussion with 
Tony, and this whole function should be fixed to check node 
compatibility instead of dev_name. I will be posting a new version that 
does this once I have time to look at it.

What do you think of patch #2 though? Thats more interesting for the 
regulator driver purposes and if you NAK that one, the floor goes under 
this whole approach.

-Tero
