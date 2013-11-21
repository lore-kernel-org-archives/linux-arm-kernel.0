From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Nov 2013 19:21:36 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131120064056.GB5272@netboy>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org> <20131118150052.GC24408@sirena.org.uk>
 <20131118191336.GB5886@quad.lixom.net> <20131119091216.GA4412@netboy>
 <20131119184827.GD20967@quad.lixom.net> <20131120064056.GB5272@netboy>
Message-ID: <20131121192136.GA16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 07:40:57AM +0100, Richard Cochran wrote:
> Now, I never saw any proclamation or discussion about "DT is in flux"
> on the arm list. If I had, I surely would have complained, and loudly.
> AFAICT, this decision was made in rather private circles, but you talk
> as if this was abundantly clear. *It was not.*

DT has been discussed several times over this year alone, which
included discussions about the stability of bindings.  Various
people in those threads (including myself) have put their views
forward.

My position has been that if an interface ends up being published in a
-final kernel, then it is part of the ABI, because a -final kernel is
an end-product.  It's a final release which says "we've done the
development, it's finished for users use."  If it's not then it shouldn't
be in a -final kernel, or if it has to be there for development purposes,
it needs to be hidden behind a "this is in development" label.

I've said that several times in the DT discussions and I believe
basically been ignored.  Frankly, I've said my bit and I've given up
caring.

If no one wants to listen, my attitude now is to just shut up and let
people learn their lessons the hard way.

A bit like what I ended up doing with the clk API and the idiocracy over
the "let's pass a NULL struct device and a system clock name because its
simple" stuff which then caused people a lot of pain... and guess what,
when done right (like the majority of cases today) it's a hell of a lot
easier.  People had to be left to find out for themselves that I was
right.
