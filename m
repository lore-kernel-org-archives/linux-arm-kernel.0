From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 18:10:09 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <1363352312.3100.175.camel@hornet>
References: <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
 <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
 <1363187979.3100.93.camel@hornet>
 <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
 <5140AA01.1010007@gmail.com> <20130315123408.GJ4977@n2100.arm.linux.org.uk>
 <1363352312.3100.175.camel@hornet>
Message-ID: <20130315181009.GV4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 12:58:32PM +0000, Pawel Moll wrote:
> On Fri, 2013-03-15 at 12:34 +0000, Russell King - ARM Linux wrote:
> > However, for SP804 selection, there are cases where it matters, such as
> > on Versatile Express where you have to select the right set of SP804 to
> > have a working system (because ARM didn't fully document the SP804 setup
> > there) and we have no way to switch some of those timers from their
> > 32kHz clock source.  But then we could just omit the clock source for
> > the "bad" SP804s which would prevent them being used.
> 
> Both VE motherboard's SP804s TIMCLKENx inputs are fed by the SP810's
> outputs:

Sigh.

You do remember who (re)wrote the Versatile Express support that's in
mainline... I know that the motherboard SP804s are clocked from the
SP810 (which has no published documentation) and these are selectable
between 1MHz and 32kHz.

What I was referring to is the SP804s on the CT9x4 tile, which seem
to be clocked at 32kHz with no way to change them, and it's that which
has been totally and utterly undocumented (believe me, when I did that
work above, I searched the available documentation many times.)

It may be that as a result of my complaints to ARM about that, the
documentation has since been fixed.  Whether it makes sense to use
the CT9x4 SP804s over the motherboards, I've no idea because I've been
forced out of the loop on Versatile Express.
