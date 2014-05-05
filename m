From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 5 May 2014 16:54:22 -0500
Subject: [PATCHv5 RFC 12/15] hwspinlock/core: add OF helper to parse
 reserved locks
In-Reply-To: <53680639.1080405@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-13-git-send-email-s-anna@ti.com>
 <53680639.1080405@ti.com>
Message-ID: <20140505215422.GD5546@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 04:44:25PM -0500, Suman Anna wrote:
> Hi Rob,
> 
> On 04/30/2014 07:34 PM, Suman Anna wrote:
> > The property 'hwlock-reserved-locks' will be used to represent
> > the number of locks to be reserved for clients that would need
> > to request/operate on specific locks. A new OF helper function,
> > of_hwspin_lock_get_num_reserved_locks(), is added to minimize
> > duplication in different platform implementations.
> > 
> > The function will return a value of 0 if the property is not
> > defined, so as to support a default behavior of marking all
> > locks as unused and open for anonymous allocations.
> > 
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > ---
> >  .../devicetree/bindings/hwlock/hwlock.txt          |  3 +++
> >  drivers/hwspinlock/hwspinlock_core.c               | 25 ++++++++++++++++++++++
> >  include/linux/hwspinlock.h                         |  1 +
> >  3 files changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
> > index d538a9b..88d16d2 100644
> > --- a/Documentation/devicetree/bindings/hwlock/hwlock.txt
> > +++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
> > @@ -18,6 +18,9 @@ Common properties:
> >  			property is needed on hwlock devices, where the number
> >  			of supported locks within a hwlock device cannot be
> >  			read from a register.
> > +- hwlock-reserved-locks: Number of locks to reserve for clients requiring
> > +			specific locks. This value cannot exceed the value of
> > +			hwlock-num-locks.
> 
> Any suggestions here on the approach? This property falls into a gray
> area as well, as the current approach is somewhat limiting (it doesn't
> support sparse reserved locks, and expects them at the beginning of the
> lock range).

Is it possible to implement a pinctrl-like hogging approach, whereby the
specific locks that need to be reserved are consumed by the controller
itself?

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
