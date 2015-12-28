From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 28 Dec 2015 14:39:35 -0800
Subject: [PATCH v2 1/3] clk: bcm2835: Add bindings for the auxiliary
 peripheral clock gates.
In-Reply-To: <87wps3qulw.fsf@eliezer.anholt.net>
References: <1450222559-22461-1-git-send-email-eric@anholt.net>
 <20151219041935.GS14936@rob-hp-laptop>
 <CAEG3pNCOO1F8+nwOQGSjUKxYCGbWW_Ripc6xUwDyg6ay66uL7w@mail.gmail.com>
 <87wps3qulw.fsf@eliezer.anholt.net>
Message-ID: <20151228223935.25842.28675@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Eric Anholt (2015-12-24 15:45:15)
> Michael Turquette <mturquette@baylibre.com> writes:
> 
> > On Fri, Dec 18, 2015 at 8:19 PM, Rob Herring <robh@kernel.org> wrote:
> >> On Tue, Dec 15, 2015 at 03:35:57PM -0800, Eric Anholt wrote:
> >>> These will be used for enabling UART1, SPI1, and SPI2.
> >>>
> >>> Signed-off-by: Eric Anholt <eric@anholt.net>
> >>> ---
> >>>
> >>> v2: Make the binding cover both the IRQ and clock enable registers.
> >>>
> >>>  .../bindings/clock/brcm,bcm2835-aux-clock.txt      | 31 ++++++++++++++++++++++
> >>>  include/dt-bindings/clock/bcm2835-aux.h            | 17 ++++++++++++
> >>>  2 files changed, 48 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
> >>>  create mode 100644 include/dt-bindings/clock/bcm2835-aux.h
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >
> > Applied to clk-next.
> >
> > Next time if you put the header into the clk driver patch then we can
> > send the binding description through the DT tree and take the header
> > and C file through the clk tree in one patch.
> 
> I would *love* to do that, but I've previously been told that having the
> bindings patch reference a header file not present as of the bindings
> patch is not acceptable and made to change it.

Ugh, that is annoying. I would think that having code compile properly
would trump the desire to have all of the documentation merged as one
patch.

On the other hand, I've been asked to not take binding descriptions
through the clk tree. That is a policy that I'm happy to comply with,
but it is at odds with the recommendation for the header and the binding
description to be merged together.

DT folks, what is the right way to do this? An immutable, shared branch
just for a single header file solves the problem, but also feels very
cumbersome for such a trivial issue.

How about allowing binding descriptions to be merged without the header
file, so long as it is merged through another tree?

Regards,
Mike
