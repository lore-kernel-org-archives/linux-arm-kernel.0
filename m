From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 10:58:20 -0700
Subject: [PATCH 2/8] clk: bcm2835: add missing PLL clock divider
In-Reply-To: <C5EA56E8-F1A1-453D-A421-3E29853F3127@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
 <1456760642-2412-3-git-send-email-kernel@martin.sperl.org>
 <87y49hjb4l.fsf@eliezer.anholt.net>
 <C5EA56E8-F1A1-453D-A421-3E29853F3127@martin.sperl.org>
Message-ID: <8737rpm1fn.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 17.03.2016, at 17:57, Eric Anholt <eric@anholt.net> wrote:
>> 
>> 
>> These don't exist on the hardware as far as I've been able to find.  "I
>> found it in a header file somewhere" is not sufficient justification to
>> expose it.
>> 
>> I'm working on getting a series of all of these reviewed and ready, so
>> I'm just dropping these PLLB hunks.
>
> Fine with that - my test shows that these are not configured by the firmware.
>
> As for headers: my experience is that these are the better resource
> compared to all the public available documentation?
>
> If you remember the ?frac? bit discussion where you said:
>
>   Once again, trusting the docs turns out to be a bad idea.  You're right,
>   the non-MASH clocks *do* have a bit 9 to enable fractional mode.  Sigh.
>
> Also my understanding is that those headers are still used by the firmware
> developers, so I guess that these are pretty stable and well maintained
> (even if the ones available are by now a bit dated).
>
> They even contain ifdefs for some earlier versions of the chip - 
> see the dma-channels and their interrupts?
> I.e: BCM2708A0 which does not have the DMA channels 9 to 15
>
> So I would not discount all those pieces of information as totally
> irrelevant.

I'm looking at the hardware source, and at the place where all the other
PLL dividers are, PLLB only has ARM.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/ba579f79/attachment.sig>
