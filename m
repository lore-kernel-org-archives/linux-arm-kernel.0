From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 23:21:26 +0100
Subject: [PATCH v3 6/6] irqchip: s3c24xx: add s3c2450 interrupt definitions
In-Reply-To: <514791DC.9070600@gmail.com>
References: <201303171404.06146.heiko@sntech.de>
 <201303181753.16547.heiko@sntech.de> <514791DC.9070600@gmail.com>
Message-ID: <2341349.u4eE8qA54r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013 17:14:52 Rob Herring wrote:
> 
> > +             s3c24xx,irqlist = <2 0 /* 2D */
> > +                                2 0 /* IIC1 */
> > +                                0 0 /* reserved */
> > +                                0 0 /* reserved */
> > +                                2 0 /* PCM0 */
> > +                                2 0 /* PCM1 */
> > +                                2 0 /* I2S0 */
> > +                                2 0>; /* I2S1 */
> 
> My first thought here is this information should not be centralized in
> the controller node, but placed with each source node (2D, I2C1, etc).

Seconded. Let's do this the same way we have it for all other irq chips
and put it all into the irq descriptor referring to the controller, not
the controller.

	Arnd
