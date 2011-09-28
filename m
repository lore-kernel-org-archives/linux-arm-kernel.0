From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 28 Sep 2011 10:20:51 +0200
Subject: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
In-Reply-To: <4E8161C7.7020404@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-3-git-send-email-b-cousson@ti.com>
	<4E8161C7.7020404@ti.com>
Message-ID: <4E82D8E3.8080405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I missed one comment...

On 9/27/2011 7:40 AM, Nayak, Rajendra wrote:
> On Monday 26 September 2011 10:20 PM, Benoit Cousson wrote:

[...]

>> +Required properties:
>> +- compatible:
>> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
>
> Would it be more readable to have
> "ti,omap2-gpio" for OMAP2 controllers and
> "ti,omap3-gpio" for OMAP3 controllers?

The point here is to identify the IP version used in various OMAPs. 
Since OMAP3 and OMAP2 are using the same IP version, there is no point 
to differentiate the OMAP3 version.
What is doable is to put both "ti,omap3-gpio", "ti,omap2-gpio" to avoid 
modifying the driver for no reason and still being able to identify the 
OMAP3 version.
But I'm not sure we should do that if there is not real difference.

regards,
Benoit
