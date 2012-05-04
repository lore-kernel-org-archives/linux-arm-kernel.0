From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 4 May 2012 11:30:21 -0500
Subject: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
 <4FA04A8C.4050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
Message-ID: <4FA4041D.9010000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 05/03/2012 03:37 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, May 02, 2012 at 02:11:48, Hunter, Jon wrote:
>>> +
>>> +	pdata->clk_prd = gpmc_get_fclk_period();
>>
>> Does this need to be done here? May be this should be done in the probe
>> function. You could store the handle to the main clk in the pdata.
> 
> This is done so that migration of gpmc driver to the drivers folder
> would be smooth, remember that this function will still live here.

Sure, but why call this here?

>>> +		pr_err("error: clk_get on %s\n", oh->main_clk);
>>> +		return -EINVAL;
>>>  	}
>>>  
>>>  	clk_enable(gpmc_l3_clk);
>>
>> I would have thought we should be able to remove the gpmc_init function
>> completely by now. Most of the code should be moved to the probe function.
>>
>> Also now with hwmod in place, we should be able to remove the
>> clk_enable/disable functions and use the pm_runtime APIs instead.
> 
> There was no plan to add rpm in this series, but now that you have
> brought it up, I will adapt the driver to rpm.

Ok, great.

Jon
