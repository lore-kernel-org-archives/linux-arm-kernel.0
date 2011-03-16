From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Wed, 16 Mar 2011 08:53:47 +0200
Subject: [PATCHv2 1/9] at91: provide macb clks with "pclk" and "hclk" name
In-Reply-To: <1300184096-13937-2-git-send-email-jamie@jamieiles.com>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-2-git-send-email-jamie@jamieiles.com>
Message-ID: <AANLkTimwwUQGhncE7Att_9rAXhpT0n61HC4SW8ShSfAm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Tue, Mar 15, 2011 at 12:14 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> The macb driver expects clocks with the names "pclk" and "hclk". ?We
> currently provide "macb_clk" but to fit in line with other
> architectures (namely AVR32), provide "pclk" and a fake "hclk".

There is no reference to a "pclk" or "hclk" in the AT91 architecture.
So to avoid possible confusion, maybe create two "fake" clocks both
parented to "macb_clk", and add a comment they're only for
compatibility with the AVR32.


Regards,
  Andrew Victor
