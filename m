From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 2 Nov 2015 17:46:05 +0200
Subject: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
In-Reply-To: <20151102154057.GQ21326@localhost>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
 <20151102100405.GJ21326@localhost> <5637534D.2020304@ti.com>
 <20151102154057.GQ21326@localhost>
Message-ID: <5637853D.8040306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On 11/02/2015 05:40 PM, Vinod Koul wrote:
> On Mon, Nov 02, 2015 at 02:13:01PM +0200, Peter Ujfalusi wrote:
>> Vinod,
>>
>> On 11/02/2015 12:04 PM, Vinod Koul wrote:
>>> On Mon, Nov 02, 2015 at 01:21:19AM -0800, Olof Johansson wrote:
>>>> Hi,
>>>>
>>>> 1) This seems to have broken BBB in -next for me, bisected down to this patch.
>>>>
>>>> For bootlog:
>>>> http://arm-soc.lixom.net/bootlogs/next/next-20151102/bbb-arm-omap2plus_defconfig.html
>>>>
>>>> 2) Please avoid merging DT/platform code in your driver tree, Vinod,
>>>> at least without an ack from the platform maintainer. It can be a a
>>>> huge mess if they end up causing conflicts, so we always ask to merge
>>>> the DT changes through the platform maintainer (Tony in this case) by
>>>> default.
>>>
>>> I did warn when applying that I am doing so without ACK on ARM code, noone
>>> said a thing!
>>>
>>> I knew Tony was following the work by Peter so assumed he must have been okay
>>> with it otherwise would have spoken for ~couple of weeks these were in
>>> review
>>>
>>> Anyway now that we have a regression, I can revert this patch if that fixes,
>>> please confirm, but might break edma... peter?
>>
>> Can you revert or drop the last two DTS patches?
>>
>> I think I will try a different route to get the split of the tpcc and tptc.
>> Without the DT patches the driver will fall back to the legacy mode so things
>> will work in a same way they did before.
>> Or I can send a followup patch for edma.c, with that there is no need to add
>> the HWMOD_INIT_NO_IDLE to hwmod and power management looks better.
>> Basically I'm registering a 'dummy' driver for the edma3-tptc so omap hwmod
>> code will not shut it down but we will keep the possibility to manage the
>> power state still.
> 
> Okay I have reverted the two and applied the edma patch sent, can you please
> verify topic/edma_fix before I merge it and send my PULL request.

The branch looks good. Thank you!
It would have been great if the DTS changes for am335x/am437x would have been
in 4.4, but I will send them for 4.5 after rc1 is out.

> Would appreciate any tested-by
> 
> Thanks
> 


-- 
P?ter
