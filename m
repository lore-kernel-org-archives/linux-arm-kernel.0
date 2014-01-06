From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 6 Jan 2014 16:12:20 +0000
Subject: [RFC] drivers: irq-chip: Enable SGI's for Secure-to-NonSecure
 communication use-cases
In-Reply-To: <20140106132536.GA27282@n2100.arm.linux.org.uk>
References: <79CD15C6BA57404B839C016229A409A83EDAD1B8@DBDE04.ent.ti.com>
 <20140106132536.GA27282@n2100.arm.linux.org.uk>
Message-ID: <79CD15C6BA57404B839C016229A409A83EDAD85E@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, January 06, 2014 6:56 PM
> To: Hiremath, Vaibhav
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; Tony
> Lindgren
> Subject: Re: [RFC] drivers: irq-chip: Enable SGI's for Secure-to-NonSecure
> communication use-cases
> 
> On Mon, Jan 06, 2014 at 05:09:04AM +0000, Hiremath, Vaibhav wrote:
> > The idea behind this RFC (or rather query) is, to get feedback or
> > comments on the use-case of using SGI for secure-to-nonsecure
> > communication on non-SMP architecture or SMP architecture with
> uniprocessor.
> > I understand that, lot of things I need to take care from SMP architecture
> perspective.
> > Based on the feedback I can spend more time to make below changes more
> > generic to handle both uniprocessor and multi-processor architectures
> including more validation.
> 
> So it seems that your intention is to use the existing infrastructure for this by
> directing SGIs through the normal IRQ processing.
> 
> To that idea, I say no way.
> 

You have any other alternative?

> I also think you need to think more about the changes you're making in your
> patch - several of them seem to have just been a case of s/32/0/ without any
> further thought whether that change is actually appropriate.
> Really, I'd suggest reading the GIC documentation, especially the bits about the
> first register being banked between each CPU.
> 
> So changing the setup in the distributor initialisation is only going to hit the
> register on the CPU it's running on...

I completely agree with you and I am willing to spend time to have more generic implementation,
which will also handle banked registers. The changes were just to prove the secure-to-nonsecure 
 communication concept which I wanted to introduce here as part of this RFC.

I will quote my statement again 

"I understand that, lot of things I need to take care from SMP architecture
perspective.
Based on the feedback I can spend more time to make below changes more
generic to handle both uniprocessor and multi-processor architectures
including more validation."

Thanks,
Vaibhav
