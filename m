From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 14:50:17 +0000
Subject: [PATCH 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <CACRpkdYu7HCBdAzqNr1pwZMgvZFyBYpcJXYo-RUx5R-U3CJ1BA@mail.gmail.com>
References: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
 <CACRpkdYu7HCBdAzqNr1pwZMgvZFyBYpcJXYo-RUx5R-U3CJ1BA@mail.gmail.com>
Message-ID: <20111220145017.GC29727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 11:01:38PM +0100, Linus Walleij wrote:

> If you check drivers/gpio/gpio-u300.c you can see how I handled
> this on another hardware where triggering on falling and rising
> edges was a binary choice and thus mutually exclusive: I toggle
> for each interrupt.

This seems like a common pattern, ideally we'd be able to factor it out
into genirq (ideally along with the other common issue with simulating
level triggered interrupts using a controller that only does edge,
though that one is more involved).
