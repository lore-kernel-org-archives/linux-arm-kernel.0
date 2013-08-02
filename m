From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 2 Aug 2013 15:52:02 +0300
Subject: [PATCH 0/2] OMAP: Panda DVI fix and a cleanup
In-Reply-To: <20130802124611.GJ7656@atomide.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
 <51FB9EDB.8010600@ti.com> <20130802124611.GJ7656@atomide.com>
Message-ID: <51FBAB72.9020108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/13 15:46, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130802 05:05]:
>> On 23/07/13 12:06, Tomi Valkeinen wrote:
>>> Hi Tony,
>>>
>>> Here's a fix for 3.11 that makes EDID read for DVI work again.
>>>
>>> I also included a cleanup patch that removes the non-DT support functions that
>>> are no longer called from anywhere. It's not a fix, but as we're in quite early
>>> rcs, I thought it would be nice to remove the dead code.
>>>
>>> Up to you if you want to include that one for 3.11 or not. If not, I'll include
>>> it in a board file series for 3.12 that I'll send soon.
>>>
>>>  Tomi
>>>
>>> Tomi Valkeinen (2):
>>>   ARM: OMAP: dss-common: fix Panda's DVI DDC channel
>>>   ARM: OMAP2+: Remove legacy DSS initialization for omap4
>>>
>>>  arch/arm/mach-omap2/dss-common.c | 49 +---------------------------------------
>>>  arch/arm/mach-omap2/dss-common.h |  2 --
>>>  2 files changed, 1 insertion(+), 50 deletions(-)
>>>
>>
>> Ping.
> 
> Oops, sorry I was offline last week and still not caught up on mails..

Ok, no prob. There's the "ARM: OMAP2+: use new display drivers" series
also waiting for you, but that's for 3.12 =).

> If you have other DSS fixes I suggest you also send these fixes:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> If not, let me know and I'll queue these.

I've got a few fbdev fixes, I can apply the fix to that branch. I'll
leave the second patch for 3.12 as it's really a cleanup (it's actually
also included in the "use new display drivers" series).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/64dc5500/attachment.sig>
