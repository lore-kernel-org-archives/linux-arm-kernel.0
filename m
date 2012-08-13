From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Mon, 13 Aug 2012 17:43:30 +0200
Subject: AT91 RM9200 hangs on delay loop calibration
In-Reply-To: <CAGhQ9Vyvr7bDU8cNirGuTkhsH1LhHPRjehftOwwSnox+i1b=5A@mail.gmail.com>
References: <CAGhQ9Vyvr7bDU8cNirGuTkhsH1LhHPRjehftOwwSnox+i1b=5A@mail.gmail.com>
Message-ID: <502920A2.9090100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

Le 08/11/2012 07:06 PM, Joachim Eastwood a ?crit :
> Hi,
>
> My custom AT91 RM9200 board hangs on delay loop calibration. There it
> seems to be stuck and the last message printed is:
> [    0.000000] Calibrating delay loop...
>
> Doing a manual bisect I can get the board to boot again when I revert
> the following commits from Linus master:
> 14070ade02cc378bc30dae383532768a94805988 - ARM: at91: fix new build errors
> c4b68520dc0ec96153bc0d87bca5ffba508edfcf - ARM: at91: add AIC5 support
> 4c6971a6debb340d487cf6189f15a1332702330f - ARM: at91: remove mach/irqs.h
> 8fe82a5550a8e97b3f59c74f994b88ed6b3544a3 - ARM: at91: sparse irq support
> 3e135466745a62b1814edef74c7b4a25e6bda707 - ARM: at91: at91 based
> machines specify their own irq handler at run time
>
> There may be some unnecessary reverts here but there are multiple
> build failures between the different commits (grrrrr) which makes it
> pain to filter it out.
>
> I suspect that right now all AT91 RM9200 machines are broken by these
> IRQ changes on AT91.
>
> regards
> Joachim Eastwood
>
>

Thanks for this report. I have just sent a patch to correct the rm9200 
breakage.

Regards

Ludovic
