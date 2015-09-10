From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 10 Sep 2015 17:57:49 +0200
Subject: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
In-Reply-To: <55F1A651.5090102@tronnes.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
 <87h9n4weg8.fsf@eliezer.anholt.net> <55F1A651.5090102@tronnes.org>
Message-ID: <8B777380-A2A1-475E-8A1C-942BF28EE160@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.09.2015, at 17:48, Noralf Tr?nnes <noralf@tronnes.org> wrote:
> 
> This looks interesting.
> But there's a challenge with the uart1 and the 8250 driver.
> 
> Phil Elwell has this to say:
> This means that that UART1 isn't an exact clone of a 8250 UART.
> In a particular, the clock divisor is calculated differently.
> A standard 8250 derives the baud rate as clock/(divisor16),
> whereas the BCM2835 mini UART uses clock/(divisor8). This means
> that if you want to use the standard driver then you need to lie
> about the clock frequency, providing a value is twice the real
> value, in order for a suitable divisor to be calculated.
> 
> Ref: https://github.com/raspberrypi/linux/pull/1008#issuecomment-139234607
> 
> So either we need a new uart1 driver or a doubled clock freq. somehow.

Found out the same thing and communicated it to Eric - not 
knowing about the different divider?

Martin
