From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 7 May 2012 11:12:35 -0500
Subject: [PATCH v4 02/39] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E987159@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <e0cf9678cb9a44d2a16401383ab8496eb825c291.1335874494.git.afzal@ti.com>
 <4FA04A8C.4050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98299B@DBDE01.ent.ti.com>
 <4FA4041D.9010000@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987159@DBDE01.ent.ti.com>
Message-ID: <4FA7F473.7060607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 05/07/2012 06:02 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Fri, May 04, 2012 at 22:00:21, Hunter, Jon wrote:
>>>>> +
>>>>> +	pdata->clk_prd = gpmc_get_fclk_period();
>>>>
>>>> Does this need to be done here? May be this should be done in the probe
>>>> function. You could store the handle to the main clk in the pdata.
>>>
>>> This is done so that migration of gpmc driver to the drivers folder
>>> would be smooth, remember that this function will still live here.
>>
>> Sure, but why call this here?
> 
> Clk_prd is a platform data passed to the driver, so platform code
> updates it, where else can it be done ?

The point is that you can pass what ever you like. You do not need to
pass the frequency you can pass the clock handle instead.

What happens it the clk_get() of the gpmc_l3_clk fails during the init?

In fact if you migrate to runtime pm then we should not have the clk_get
in the gpmc_init any more.

Jon
