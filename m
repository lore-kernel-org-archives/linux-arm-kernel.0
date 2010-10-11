From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 11 Oct 2010 14:18:04 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <4CB2FF17.1020803@pengutronix.de> (Marc Kleine-Budde's message of
	"Mon, 11 Oct 2010 14:12:07 +0200")
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<4CB2FF17.1020803@pengutronix.de>
Message-ID: <87k4loorcz.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Marc" == Marc Kleine-Budde <mkl@pengutronix.de> writes:

Hi,

 Marc> On 10/11/2010 01:59 PM, Peter Korsgaard wrote:
 >> Documentation/gpio.txt specifies that the value argument to
 >> gpio_set_value() should be handled as a boolean (E.G. != 0 is high),
 >> so use the same logic as in _set_direction().
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 >> ---
 >> arch/arm/plat-mxc/gpio.c |    7 ++++++-
 >> 1 files changed, 6 insertions(+), 1 deletions(-)
 >> 
 >> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
 >> index 57ec4a8..e226801 100644
 >> --- a/arch/arm/plat-mxc/gpio.c
 >> +++ b/arch/arm/plat-mxc/gpio.c
 >> @@ -234,8 +234,13 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 >> u32 l;
 >> unsigned long flags;
 >> 
 >> +
 >> spin_lock_irqsave(&port->lock, flags);
 >> -	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);

 Marc> what about using "!!value" instead of just "value".

Sure, that's equivalent, but I found that harder to read. My form has
the extra advantage that it matches the structure of
_set_gpio_direction() just above.

-- 
Bye, Peter Korsgaard
