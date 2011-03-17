From: avictor.za@gmail.com (Andrew Victor)
Date: Thu, 17 Mar 2011 11:22:37 +0200
Subject: [PATCHv2 1/9] at91: provide macb clks with "pclk" and "hclk" name
In-Reply-To: <20110316083844.GA13262@n2100.arm.linux.org.uk>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-2-git-send-email-jamie@jamieiles.com>
	<AANLkTimwwUQGhncE7Att_9rAXhpT0n61HC4SW8ShSfAm@mail.gmail.com>
	<20110316083844.GA13262@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin9FH2orOaV-6feGDikCGvb3C-Q2CnRzp-Y2S4X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell,

>> There is no reference to a "pclk" or "hclk" in the AT91 architecture.
>> So to avoid possible confusion, maybe create two "fake" clocks both
>> parented to "macb_clk", and add a comment they're only for
>> compatibility with the AVR32.
>
> It doesn't matter what's in the documentation.
>
> What matters more than conforming to documentation is keeping the drivers
> in a clean and maintainable state without throwing lots of ifdefs into
> them.

I'm not saying the drivers need ifdefs, they should request both
"pclk" and "hclk" as suggested.

What I was suggesting is the platform clock setup on AT91 as:
    macb_clk
        |
        +-- hclk
        +-- pclk

rather than:
    pclk
        |
        +-- hclk

Regards,
  Andrew Victor
