From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 31 Aug 2011 14:17:15 +0200
Subject: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking
	for each DAIs separately
In-Reply-To: <4E5E213A.8040909@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>
	<4E5E1285.8020508@ti.com> <4E5E213A.8040909@freescale.com>
Message-ID: <4E5E264B.8000004@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2011 01:55 PM, Tabi Timur-B04825 wrote:
> Liam Girdwood wrote:
>> Timur, iirc your driver has some special symmetry requirement (maybe something todo with having 2 DAIs) ?
>>
>> I assume this is OK for you too ?
> 
> Yes, that's why I was asking.  I believe I'm affected by this patch as 
> well, so I will test it.  However, I never noticed a problem before, so 
> I'm not sure what's going on.
> 

The problem is that if the DAI is shared between two links the symmetry
constraint is not applied and both links could be configured to run at
different rates.

Without the patch for example 'aplay -r 8000 ... & arecrod -r 16000 ...' would
result in playback running twice as fast as it is supposed to.
