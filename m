From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jun 2013 15:55:01 -0400
Subject: [PATCH] ARM: omap5: build opp4xxx_data.c
In-Reply-To: <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna>
 <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
Message-ID: <51C9F595.3060609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 June 2013 03:20 PM, Paul Walmsley wrote:
> Santosh,
> 
> On Fri, 21 Jun 2013, Nishanth Menon wrote:
> 
>> 	/*
>> 	 * XXX Will depend on the process, validation, and binning
>> 	 * for the currently-running IC. Use OMAP4 data for time being.
>> 	 */
>> #ifdef CONFIG_PM_OPP
>> 	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
>> 	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
>> 	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
>> #endif
>>
>> Should we just remove this instead? these are obviously wrong.
> 
> Are the OMAP4460 values expected to work and be safe for OMAP5, or not?  
> If the latter, please send a patch to remove them.
> 
The plan was to update the data along with and VC OPP update
for OMAP5 which Keerthy is working on. As such without VC code,
this data is not doing anything so it is safe.

Regards,
Santosh
