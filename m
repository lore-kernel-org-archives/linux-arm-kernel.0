From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 18:53:05 +0200
Subject: [PATCH] GPIO: mvebu-gpio: Don't initialize the mask_cache
In-Reply-To: <CACRpkdYE_P_MQch4dLuCBeUXEfr2RG3TwdUMdT75cN3MELG3pQ@mail.gmail.com>
References: <1351344538-5238-1-git-send-email-andrew@lunn.ch>
 <CACRpkdYE_P_MQch4dLuCBeUXEfr2RG3TwdUMdT75cN3MELG3pQ@mail.gmail.com>
Message-ID: <20121027185305.71d88c07@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sat, 27 Oct 2012 18:31:41 +0200, Linus Walleij wrote:
> On Sat, Oct 27, 2012 at 3:28 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Due to the SMP nature of some of the chips, which have per CPU
> > registers, the driver does not use the generic irq_gc_mask_set_bit() &
> > irq_gc_mask_clr_bit() functions, which only support a single register.
> > The driver has its own implementation of these functions, which can
> > pick the correct register depending on the CPU being used. The
> > functions do however use the gc->mask_cache value.
> >
> > The call to irq_setup_generic_chip() was passing
> > IRQ_GC_INIT_MASK_CACHE, which caused the gc->mask_cache to be
> > initialized to the contents of some random register. This resulted in
> > unexpected interrupts been delivered from random GPIO lines.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Thanks, patch applied to fixes. Unless Thomas screams...

Acked-by-the-not-screaming: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Sounds good? :-)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
