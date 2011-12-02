From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Dec 2011 14:31:13 +0100
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <20111202130242.GO8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com> <4ED8C57B.2000503@ti.com>
 <20111202130242.GO8245@opensource.wolfsonmicro.com>
Message-ID: <4ED8D321.7030904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/2/2011 2:02 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 02:32:59PM +0200, Peter Ujfalusi wrote:
>
>> As of now we receive all these information via OMAP hwmod.
>> All the properties (addresses, irq, etc) of the HW IP will be coming
>> from DT as soon as I can remove the ti,hwmod property.
>
> Oh, right.  We should really be churning the device tree like this - the
> idea is that the device tree should be stable and independant of kernel
> versions.  It would be better if we were able to go straight to the one
> without hwmod, especially if Benoit is able to get the underlying
> changes done soon (which sounded like it might be the case).

I wish it were that easy... but there are too many bindings that are not 
yet there in DT core.

Even if the reg-names and interrupts-names are accepted, which is still 
not obvious due to a little bit of resistance, we still do not have dma 
request bindings, nor clock bindings, nor pin mux.
All these information are provided today by hwmod, so it will still be 
there for a couple of more merge windows.

The important point for me, it to avoid having to change the driver 
whenever these bindings will be there. This will be OK today for reg and 
interrupts since they both go through Linux resources.

> Could we define and implement the "real" version now (it should be reasonable to
> code blind except possibly for the DMA channel as it's such a direct
> mapping) with hwmod left in there as something that's legacy for old
> kernels?

I think DT churn is unavoidable due to the ongoing effort to add clock, 
regulator, dma, pin mux into DT core.
I don't think we should wait to have all that ready to start migrating 
to DT.

Regards,
Benoit
