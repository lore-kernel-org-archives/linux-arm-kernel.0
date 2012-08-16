From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 08:09:21 +0000
Subject: [PATCH V3 3/5] clk: mmp: add clock definition for pxa910
In-Reply-To: <CADApbej91_Y84sC9R1b0+LgDTzFUH8CveYsDi4wDWOQxkGnnFg@mail.gmail.com>
References: <1345086525-12328-1-git-send-email-xiechao.mail@gmail.com>
 <201208160717.03707.arnd@arndb.de>
 <CADApbej91_Y84sC9R1b0+LgDTzFUH8CveYsDi4wDWOQxkGnnFg@mail.gmail.com>
Message-ID: <201208160809.21662.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Chao Xie wrote:
> >> +     clocks[uart0_mux] =
> >> +         clk_register_mux(NULL, "uart0_mux", uart_parent,
> >> +                          ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
> >> +                          apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);


> i can change remove the clocks array, but even make the sentence
> shorter, most of them still can not fit in one line.

Don't worry too much about the line length or a particular style. This is
all about readability, and the style you use above may conform to some
written style guide, but it's not the most readable one. If you reformat
it to 

	clk = clk_register_mux(NULL, "uart0_mux", uart_parent, ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT, apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);

or

	clk = clk_register_mux(NULL, "uart0_mux", uart_parent, ARRAY_SIZE(uart_parent),
		CLK_SET_RATE_PARENT, apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);

or

	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
		 ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
		 apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);

I still find that more readable.

	Arnd
