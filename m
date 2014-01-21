From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jan 2014 19:50:06 +0100
Subject: [PATCH RFC 4/6] net: rfkill: gpio: add device tree support
In-Reply-To: <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <201401211335.16885.arnd@arndb.de>
 <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
Message-ID: <201401211950.07011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 January 2014, Alexandre Courbot wrote:
> >> As discussed earlier in this thread I'm not sure the con_id is
> >> suitable for labelling GPIOs. It'd be better to have a proper name
> >> specified in DT/ACPI instead.
> >
> > +1
> 
> I wonder why you guys prefer to have the name defined in the GPIO
> mapping. Having the driver decide the label makes it easier to look up
> which GPIO does what in debugfs, whereas nothing prevents people to
> name GPIOs whatever inadequate name they want in the device DT node.
> What am I overlooking here?

I should have another look at the debugfs representation, but isn't
there a global namespace that gets used for all gpios?  Neither the
con_id nor the name that the driver picks would be globally unique
and stable across kernel versions, so they don't make a good user
interface.

I think what we want here is a system-wide unique identifier for
each gpio line that may get represented in debugfs, and use a new
DT mechanism to communicate that.

	Arnd
