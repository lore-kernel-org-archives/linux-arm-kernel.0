From: b32955@freescale.com (Huang Shijie)
Date: Thu, 7 Jul 2011 11:23:28 +0800
Subject: [PATCH] dmaengine: mxs-dma: skip request_irq for NO_IRQ
In-Reply-To: <20110707032441.GF4034@S2100-06.ap.freescale.net>
References: <20110630052855.GE25931@S2100-06.ap.freescale.net>
	<1309421193-7785-1-git-send-email-shawn.guo@linaro.org>
	<20110707001530.GE4034@S2100-06.ap.freescale.net>
	<1310004360.20150.16.camel@psiaudioba-mobl1>
	<20110707032441.GF4034@S2100-06.ap.freescale.net>
Message-ID: <4E1526B0.5060308@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2011?07?07? 11:24, Shawn Guo ??:
> On Thu, Jul 07, 2011 at 07:36:00AM +0530, Vinod Koul wrote:
>> On Thu, 2011-07-07 at 08:15 +0800, Shawn Guo wrote:
>>> On Thu, Jun 30, 2011 at 04:06:33PM +0800, Shawn Guo wrote:
>>>> In general, the mxs-dma users get separate irq for each channel,
>>>> but gpmi is special one which has only one irq shared by all gpmi
>>>> channels.  It causes mxs_dma channel allocation function fail for
>>>> all other gpmi channels except the first one calling into the
>>>> function.
>>>>
>>>> The patch gets request_irq call skipped for NO_IRQ case, and leaves
>>>> this gpmi specific quirk to gpmi driver to sort out.  It will fix
>>>> above problem if gpmi driver sets chan_irq as gpmi irq for only one
>>>> channel and NO_IRQ for all the rest channels.
>>>>
>>>> Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
>>>> Cc: Vinod Koul<vinod.koul@intel.com>
>>>> ---
>>> Hi Vinod,
>>>
>>> Can you please take this patch?
>>>
>>> Regards,
>>> Shawn
>> Looks okay to me. Have queued it up and should show up in my tree latest by early next week.
>> I am on road, hence the delay...
>>
> No problem.  Thanks, Vinod.
>
thanks. I will submit the next GPMI version which will based this patch.

Best Regards
Huang Shijie
