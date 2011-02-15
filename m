From: hemantp@ti.com (Pedanekar, Hemant)
Date: Tue, 15 Feb 2011 06:39:27 +0530
Subject: [PATCH RESEND v6 2/4] TI816X: Update common OMAP machine
	specific sources
In-Reply-To: <87tyg6xkm0.fsf@ti.com>
References: <1297695819-27027-1-git-send-email-hemantp@ti.com>
	<87tyg6xkm0.fsf@ti.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036AD56F51@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hilman, Kevin wrote on Tuesday, February 15, 2011 4:58 AM:

> Hemant Pedanekar <hemantp@ti.com> writes:
> 
> [...]
> 
>> @@ -402,7 +422,7 @@ void __init
> omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
>> 
>>  	omap_hwmod_late_init();
>> 
>> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>> +	if (omap3_has_sdrc()) {
>>  		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>>  		_omap2_init_reprogram_sdrc();
>>  	}
> 
> At first glance, this one doesn't look quite right.  Will
> omap3_has_sdrc()  be true on 24xx?   Please confirm.
> 
> Kevin

You are right, this is incorrect as there is no 'features' set for
omap24xx. I will send new version with cpu_is_omap24xx() check retained.

Thanks.
   Hemant
