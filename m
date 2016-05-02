From: eric@anholt.net (Eric Anholt)
Date: Mon, 02 May 2016 08:36:18 -0700
Subject: [PATCH V4 1/2] clk: bcm2835: mark enabled clocks with
 CLK_IS_CRITICAL
In-Reply-To: <1461951756-16804-2-git-send-email-kernel@martin.sperl.org>
References: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
 <1461951756-16804-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <87zis8h3pp.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The bcm2835 firmware enables several clocks and plls before
> booting the linux kernel.
>
> These plls should never get disabled as it may result in a
> stopped system clock and more.
>
> So during probing we check if the clock is enabled
> and if it is then mark that clock with CLK_IS_CRITICAL.
>
> As a consequence this will also enable the corresponding
> parent plls and pll-divs.
>
> This is intended as a stop-gap until CLK_ENABLE_HAND_OFF
> becomes available, at which point it should be used instead.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

I still think that we don't want this patch.  We should be able to
disable clocks that the firmware turned on, unless they really need to
stay on.  If you have troubles on the upstream DT, let's talk about
individual clocks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/6d3b4a8c/attachment.sig>
