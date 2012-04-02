From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 2 Apr 2012 19:37:23 +0100
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409AE8@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0020698409AE8@AUSP01VMBX24.collaborationhost.net>
Message-ID: <CACb=_tStuw4CLWwBGjFmViQYYf-PD4C_VN7FPO9tZCp_tPY+kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2012 19:27, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
> On Monday, April 02, 2012 11:16 AM, Jamie Iles wrote:
>> On 2 April 2012 18:55, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>>> 2) Should the vic status be re-checked after each interrupt is handled in
>>> handle_one_vic? This could cause a problem where an aggressive interrupt,
>>> i.e. the timer on ep93xx, could cause other interrupts to not get handled quickly.
>>
>> No, I think I may have had this when I first introduced this code and
>> there were objections to the fairness of that, so the current approach
>> where we try and service each interrupt before restarting was the most
>> fair way of doing it.
>
> I remember seeing this discussion on the list. I agree the current approach
> is the most "fair" way of handling the interrupts.
>
>> I wonder if looking at IRQ tracing to find out when and where
>> interrupts are being enabled from might be useful for tracking this
>> down.
>
> I'm willing to do the IRQ tracing... How... ;-)
>
> I don't see anything in the Kernel Hacking options to enable IRQ tracing.

It looks like the irqsoff tracer has a dependency on
!ARCH_USES_GETTIMEOFFSET which is defined for ep93xx.  I'll have a
think to see if there's another way to tackle this, but at the moment
there's nothing that springs to mind...

Jamie
