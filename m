From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 11:28:41 +0000
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <01e101cd0042$5bf692a0$13e3b7e0$@lge.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
 <20120312083221.GW17370@n2100.arm.linux.org.uk>
 <01e101cd0042$5bf692a0$13e3b7e0$@lge.com>
Message-ID: <20120312112841.GY17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 08:22:07PM +0900, Kim, Jong-Sung wrote:
> Maybe the character is handled on next upcoming RTIS or RXIS in normal.
> However, I agree with you there is possibility of already asserted RXIS at
> this point. (with debugger?) In such a case, we may lose Rx interrupts
> forever because it's not level-triggered, and the ISR lacks error interrupt
> handling. Correct me if something wrong.

The handler does not lack error handling - error handling is associated
with a character, and we deal with errors when we read the associated
character from the receive register.

So, we have no need for the error interrupts.

The PL011, as with all serial drivers I write, has full error handling
incorporated.
