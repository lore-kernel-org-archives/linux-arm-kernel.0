From: svenkatr@ti.com (Venkatraman S)
Date: Fri, 26 Oct 2012 16:45:17 +0530
Subject: [RFC/PATCH] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
In-Reply-To: <20121025180418.GB18046@arwen.pp.htv.fi>
References: <1350910768-8522-1-git-send-email-balbi@ti.com>
 <20121022132708.GA14033@arwen.pp.htv.fi>
 <20121025180418.GB18046@arwen.pp.htv.fi>
Message-ID: <508A70C5.1000407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012 11:34 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Oct 22, 2012 at 04:27:08PM +0300, Felipe Balbi wrote:
>> On Mon, Oct 22, 2012 at 03:59:28PM +0300, Felipe Balbi wrote:
>>> prepare() is supposed to prevent new children from
>>> being registered. On the MMC subsystem, children
>>> (new cards) registration starts with the card
>>> detect IRQ.
>>>
>>> Move card detect IRQ disabling to prepare() so that
>>> no new cards will be registered while we're trying
>>> to suspend.
>>>
>>> Likewise, move card detect IRQ enabling to complete()
>>> so we only try to register new children after our MMC
>>> IP is back up.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>
>>> Venkat, do you think the patch below makes sense ?
>> btw, just checked suspend to ram with beagle and panda. We still have
>> our filesystem after waking up.
>>
>> ps: you will [1] to test it:
>>
>> [1] http://marc.info/?l=linux-arm-kernel&m=135090724817604&w=2
> ping
>
I've been off for the past 3 days. Will test this on Monday once I'm 
back in office.
