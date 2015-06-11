From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 11 Jun 2015 17:53:47 +0300
Subject: EDMA oftree entry for AM335x
In-Reply-To: <20150611141330.GC2740@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com>
 <20150505145828.GB21061@atomide.com> <5549F95B.8090905@ti.com>
 <20150506143951.GG21061@atomide.com> <20150608105957.GT26523@pengutronix.de>
 <20150610051037.GA2740@atomide.com> <55781BDA.9020705@ti.com>
 <20150611141330.GC2740@atomide.com>
Message-ID: <5579A0FB.6000800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2015 05:13 PM, Tony Lindgren wrote:
>> Well, I was not.
>> But I'm now ;)
> 
> OK good to hear!

I have a working version now, but...
Due to the scale of the needed changes we would need different compatible
string for the single hwmod version.
The Linux driver itself works fine if I don't change the compatible
(ti,edma3). Boots fine with the old and new DTS file, but the edma sections
are not compatible anymore IMO.

I don't want to rush in a new binding for it since I want to make sure that
the new binding will be usable when I got the chance to rewrite the edma stack
(get rid of the code from arch/arm/common/edma.c)

We have the xbar support embedded in the current edma driver - not the same
crossbar as we have in dra7, it is a bit more problematic (very problematic).
Currently we do not have support for more than one TPCC via DT, legacy boot on
SoC with more than one TPCC is also going to be interesting.

Since we will need new bindings for the edma when we fix the multiple hwmods I
think we should allow us some time to think about it a bit and come up with
something which will work in the future and it is nice to look at it at the
same time ;)

And I will be away for one week...
If you want I can send an RFC/DO NOT MERGE series with the code I have
tomorrow in case you want to see it, but I think it will look quite a bit
different at the end.

-- 
P?ter
