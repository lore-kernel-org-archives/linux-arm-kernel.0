From: thara@ti.com (Gopinath, Thara)
Date: Fri, 17 Sep 2010 20:27:10 +0530
Subject: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
In-Reply-To: <4C92246C.3010404@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-3-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
	<4C920A49.5010105@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032944262A@dbde02.ent.ti.com>
	<4C92246C.3010404@ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329539FDF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Thursday, September 16, 2010 7:37 PM
>>To: Gopinath, Thara
>>Cc: Kevin Hilman; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>>Subject: Re: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
>>
>>Gopinath, Thara had written, on 09/16/2010 08:51 AM, the following:
>>>
>>>>> -----Original Message-----
>>>>> From: Menon, Nishanth
>>>>> Sent: Thursday, September 16, 2010 5:45 PM
>>>>> To: Gopinath, Thara
>>>>> Cc: Kevin Hilman; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>>>>> Subject: Re: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
>>>>>
>>>>> Gopinath, Thara had written, on 09/16/2010 05:40 AM, the following:
>>>>>>>> -----Original Message-----
>>>>>>>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of
>>>>> Kevin
>>>>>>>> Hilman
>>>>>>>> Sent: Thursday, September 16, 2010 3:27 AM
>>>>>>>> To: linux-omap at vger.kernel.org
>>>>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>>>>> Subject: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
>>>>>>>>
>>>>>>>> From: Paul Walmsley <paul@pwsan.com>
>>>>>>>>
>>>>>>>> The OPP layer code should be independent of the PMIC,
>>>>>>>> introduce the TWL/TPS-specific code out to its own file.
>>>>>> Hello Kevin,
>>>>>>
>>>>>> I have been using this code for a while now. I really do not think wee need a separate
>>>>>> file for implementing the vsel to voltage in (uV) and vice versa formulas. Today only voltage
>>>>> This split introduces a PMIC level abstraction already. Do you have a
>>>>> suggestion which file it should go to? It is definitely not part of
>>>>> opp.c, not part of other existing twl files as well. the job of this
>>>>> file was to introduce conversion routines which can be used by any layer
>>>>> (voltage layer if need be - it used to be srf and smartreflex before)..
>>>>> in fact one of your voltage layer patches introduces capability for 6030
>>>>> as well
>>>>> http://marc.info/?l=linux-omap&m=128213020927919&w=2
>>>
>>> Yes one of my patches has introduces this coz I had no other way
>>> to add OMAP4 support. But I still do not understand why cant these
>>> APIs be implemented in twl-core.c or twl4030-power.c?
>>Why there? Twl power does regulator operations not conversion
>>operations. core is not the place either as it is function independent.

Hello Nishant,

Why  do you say core is not the place. For me core is exactly
the place. It is the PMIC driver file.

Regards
Thara
