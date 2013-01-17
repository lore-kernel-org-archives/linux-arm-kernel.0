From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 14:10:18 +0200
Subject: [PATCH v7 15/22] mfd: omap-usb-host: Manage HSIC clocks for HSIC
 mode
In-Reply-To: <20130117114522.GF18978@arwen.pp.htv.fi>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-16-git-send-email-rogerq@ti.com>
 <20130117114522.GF18978@arwen.pp.htv.fi>
Message-ID: <50F7EA2A.2080705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 01:45 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jan 17, 2013 at 01:30:24PM +0200, Roger Quadros wrote:
>> @@ -598,6 +639,24 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  				clkname, PTR_ERR(pclk));
>>  		else
>>  			omap->utmi_clk[i] = pclk;
>> +
>> +		snprintf(clkname, sizeof(clkname),
>> +				"usb_host_hs_hsic480m_p%d_clk", i + 1);
> 
> do we really need to know the exact clock node name ?
> 
I think so. Do you have a better suggestion?

--
cheers,
-roger
