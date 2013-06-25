From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jun 2013 16:12:03 -0400
Subject: [PATCH] ARM: omap5: build opp4xxx_data.c
In-Reply-To: <20130625195751.GA6529@kahuna>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna>
 <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
 <51C9F595.3060609@ti.com> <20130625195751.GA6529@kahuna>
Message-ID: <51C9F993.6050109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 June 2013 03:57 PM, Nishanth Menon wrote:
> On 15:55-20130625, Santosh Shilimkar wrote:
>> On Tuesday 25 June 2013 03:20 PM, Paul Walmsley wrote:
>>> Santosh,
>>>
>>> On Fri, 21 Jun 2013, Nishanth Menon wrote:
>>>
>>>> 	/*
>>>> 	 * XXX Will depend on the process, validation, and binning
>>>> 	 * for the currently-running IC. Use OMAP4 data for time being.
>>>> 	 */
>>>> #ifdef CONFIG_PM_OPP
>>>> 	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
>>>> 	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
>>>> 	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
>>>> #endif
>>>>
>>>> Should we just remove this instead? these are obviously wrong.
>>>
>>> Are the OMAP4460 values expected to work and be safe for OMAP5, or not?  
>>> If the latter, please send a patch to remove them.
>>>
>> The plan was to update the data along with and VC OPP update
>> for OMAP5 which Keerthy is working on. As such without VC code,
>> this data is not doing anything so it is safe.
> opp data in mach-omap2 is no longer used. everything is moving to dts
> and OMAP5 is dts only. *IF* this is preventing boot, then we can hack
> something in while we continue to debate on what we RFCs we have posted
> so far.
>
The boot is just fine as I said, the setting doesn't have any effect
without the code which is going to use that data.
 
> Further, OPPs are NOT for Voltage Controller (VC). It is meant for
> specific domains like MPU, SGX etc.. Having that data here, especially
> wrong data is just plain wrong IMHO.
>
Well having voltage data in voltage domain was not my decision ;-)
Instead of creating another set of dummy data, I just used what
is out there(OMAP4) with clear comment that data needs to be updated.
I don't see any problem in this considering we have devices booting
and working nicely for OMAP5

Regards,
Santosh
 
