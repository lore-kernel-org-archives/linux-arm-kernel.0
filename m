From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 21 Jan 2014 19:57:50 +1100
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
In-Reply-To: <CAOesGMjrLs9eEPurjUpOfgyexnc__FJkRYmAR84_f7C15HH07Q@mail.gmail.com>
References: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com>
 <20140115161224.GH25824@e106331-lin.cambridge.arm.com>
 <20140120224742.EC905C40B12@trevor.secretlab.ca>
 <CAOesGMjrLs9eEPurjUpOfgyexnc__FJkRYmAR84_f7C15HH07Q@mail.gmail.com>
Message-ID: <20140121085750.GC21650@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 05:03:23PM -0800, Olof Johansson wrote:
> On Mon, Jan 20, 2014 at 2:47 PM, Grant Likely <grant.likely@linaro.org> wrote:
> > On Wed, 15 Jan 2014 16:12:24 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >
> >> > Another, more invasive option would be extend the dts syntax and teach
> >> > dtc to handle property appending. Then the soc dts could stay as it is,
> >> > and the board dts could have something like:
> >> >
> >> >     /append-property/ interrupts = <&intc1 6 1>;
> >> >     /append-property/ interrupt-names = "board-specific-irq";
> >> >
> >> > Both these options solve the issue at the source, are general to other
> >> > properties, and allow more than one level of hierarchy (the proposed
> >> > interrupts-extended-2 only allows one level).
> >>
> >> I've just had a go at implementing the append-property mechanism above
> >> in dtc, and it was far easier than I expected (patch below).
> >>
> >> Does anyone have any issues with the /append-property/ idea?
> >
> > I think that is reasonable.
> 
> 
> The main problem with this (same for clocks) is if you need to append
> something with a name when the original didn't have any.
> 
> Reordering entries might not work for interrupts, since the bindings
> might have requirements on order.
> 
> I'm not aware of a good solution for this. Suggestions welcome.

So, in principle my preferred way to handle things like this would be
to add richer expression support, including a token for "previous
value" when overlaying.

But although I've recently had another look at it, that's still a ways
off, so I wouldn't object to another approach as a stopgap, as long as
its not too hideous.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140121/a8e3ce63/attachment.sig>
