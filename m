From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Jan 2010 09:53:04 +0100
Subject: [PATCH] Updated: Fix soft lockup in at91 udc driver
In-Reply-To: <4B4F7576.9090008@bluewatersys.com>
References: <4B4F7576.9090008@bluewatersys.com>
Message-ID: <20100119085304.GA17708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 15, 2010 at 08:50:14AM +1300, Ryan Mallon wrote:
> Fix a potential soft lockup in the AT91 UDC driver by ensuring that the
> UDC clock is enabled inside the interrupt handler. If the UDC clock is
> not enabled then the UDC registers cannot be written to and the
> interrupt cannot be cleared or masked.
Wouldn't it be cleaner to assert that the clock is already on when an
irq comes in?  That is enable the clock and let it enabled when
configuring the device to generate irqs?

Just my 2?
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
