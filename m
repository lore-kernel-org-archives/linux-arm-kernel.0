From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 30 May 2011 01:33:26 +0400
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
Message-ID: <BANLkTi=RWG_iiyd1f_aGEpqk9Cbh1dT7iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 1:17 AM, David Rientjes <rientjes@google.com> wrote:
> On Sun, 29 May 2011, Dmitry Eremin-Solenikov wrote:
>
>> What about changing your patch for less intrusive one (to emit a
>> WARN_ON) for at least one
>> or two major releases and only then changing it back to the current state?
>>
>
> That would return memory that is not guaranteed to be within the first
> 16MB of address space, so a GFP_DMA allocation would succeed with memory
> not from ZONE_DMA. ?That's an invalid configuration, so users, including
> you, should at least edit their .config by hand to enable CONFIG_ZONE_DMA
> as a workaround. ?Then, we should try to fix up the Kconfig entries for
> drivers requiring DMA allocations to select CONFIG_ZONE_DMA or fix
> defconfigs when DMA is known to be needed for a device.

Am I right that this was the previous behaviour for GFP_DMA allocations
w/o CONFIG_ZONE_DMA? If so, we can have it (probably) for one more
major release to get all warnings.

-- 
With best wishes
Dmitry
