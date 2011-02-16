From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Feb 2011 19:41:42 +0100
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <8yaoc6c7tan.fsf@huya.qualcomm.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
Message-ID: <AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/16 David Brown <davidb@codeaurora.org>:
> On Tue, Feb 15 2011, Russell King - ARM Linux wrote:
>
>> This patch is for RFC only; it needs splitting up somewhat. ?However, I
>> wanted to get it out there for some comment.
>
> Just for kicks, I applied this and ran it on an MSM target (8x50). ?It
> seems to cause lots of:
>
> ?mmc0: Data timeout
> ?mmc0: Controller has been re-initialized
> ?...
> ?mmc0: Data CRC error
>
> and I can post more if you would find them interesting. ?Eventually the
> MSM mmc driver derefernces a null pointer in the interrupt code.
>
> It's also possible this is finding problems in our SDCC driver.

The SDCC is obviously an MMCI derivate, VHDL hacking
on top of ARMs source code for PL180/PL181.

Why do you insist on maintaining a forked driver?

Please consider switching to using mmci.c like everyone else.
The quirks we have in place for U300, Nomadik and Ux500
should show you the way for how to do this (yes we did the
same thing, hacking the ARM VHDL).

If I remember correctly I could even see that some early
Android sources were using Russells mmci.c driver before this
fork was created.

Yours,
Linus Walleij
