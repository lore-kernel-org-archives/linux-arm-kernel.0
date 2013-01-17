From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 14:45:16 +0200
Subject: [PATCH v7 15/22] mfd: omap-usb-host: Manage HSIC clocks for HSIC
 mode
In-Reply-To: <20130117122757.GO18978@arwen.pp.htv.fi>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-16-git-send-email-rogerq@ti.com>
 <20130117114522.GF18978@arwen.pp.htv.fi> <50F7EA2A.2080705@ti.com>
 <20130117122757.GO18978@arwen.pp.htv.fi>
Message-ID: <50F7F25C.3060909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 02:27 PM, Felipe Balbi wrote:
> On Thu, Jan 17, 2013 at 02:10:18PM +0200, Roger Quadros wrote:
>> On 01/17/2013 01:45 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Thu, Jan 17, 2013 at 01:30:24PM +0200, Roger Quadros wrote:
>>>> @@ -598,6 +639,24 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>>>  				clkname, PTR_ERR(pclk));
>>>>  		else
>>>>  			omap->utmi_clk[i] = pclk;
>>>> +
>>>> +		snprintf(clkname, sizeof(clkname),
>>>> +				"usb_host_hs_hsic480m_p%d_clk", i + 1);
>>>
>>> do we really need to know the exact clock node name ?
>>>
>> I think so. Do you have a better suggestion?
> 
> update CLKDEV entries ? I mean, what if we have a new OMAP or AMxxxx
> device with a different clock name ? That will be a big bummer.
> 

In that case we simply need to add the relevant CLKDEV entries/aliases
for the new platform. I don't think anything needs to be changed in the
driver. We are still using clk_get(dev, clk_name), so the CLKDEV
framework will return the best matching clock for the device.

--
cheers,
-roger
