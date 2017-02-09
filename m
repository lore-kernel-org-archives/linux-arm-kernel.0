From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 9 Feb 2017 10:00:05 -0600
Subject: [PATCH v3 1/3] of: Support parsing phandle argument lists through
 a nexus node
In-Reply-To: <20170209153526.GF27312@n2100.armlinux.org.uk>
References: <20170123204851.12808-1-stephen.boyd@linaro.org>
 <20170123204851.12808-2-stephen.boyd@linaro.org> <5886F5ED.3030509@gmail.com>
 <CAL_JsqKS3Q2mg0aSubB3TV6LPQjCx+hqBu4TqbsqyfBvWrwctg@mail.gmail.com>
 <CAL_JsqKbkynNmCrXbi=VJ5wqYtRrYbC+00qSm_uyZFBLFOUz0w@mail.gmail.com>
 <20170209153526.GF27312@n2100.armlinux.org.uk>
Message-ID: <CAL_JsqKmkkPobGGzOOcbt2Nbx1=y=+C_167dVKHqrP0UgHBe_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2017 at 9:35 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Feb 09, 2017 at 09:17:58AM -0600, Rob Herring wrote:
>> Frank, any more comments on this? If not, I plan to apply this series.
>
> Well, I find that a little annoying, because DT has the requirement
> that new bindings are properly documented in Documentation, and it
> appears that this comes with no documentation what so ever, despite
> introducing new properties (like the -map-mask-passthru thing).
>
> So I'm NAKing it until there's some documentation of how this
> mechanism is supposed to work.
>
> Merely providing an example in a commit log is (IMHO) insufficient.
> An example doesn't explain how it was created, or how to create an
> implementation.

Yes, you are right.

However, I'd like to see this documented in the DT spec, rather than
kernel Documentation/ as this is a core binding. Though that would
also imply first moving the GPIO bindings there. Perhaps just how this
works generically could be in the spec, but the GPIO specifics can
live with the rest of the GPIO bindings for now. This is intended to
extend to other bindings.

> Remember, we expect people to do exactly that, so we need to give
> them this information so that they can make use of it.
>
> I did try to work out from the code how the -map-mask thing worked,
> but eventually gave up.

The code is definitely hard to follow and I've not come up with any
ways to make it easier to read. It's largely copied from the
interrupt-map version, but different enough that sharing isn't really
possible either.

For interrupts, it's documented in the DT spec. The best (only?)
explanation for how interrupt-map works is here[1] (used to be at
devicetree.org).

Rob

[1] http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
