From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 2 Oct 2013 23:54:50 +1000
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
Message-ID: <20131002135450.GH6506@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:
> On Tue, Oct 1, 2013 at 10:06 AM, Benoit Cousson <bcousson@baylibre.com> wrote:
> > Hi Rob,
> >
> >
> > On 01/10/2013 15:17, Rob Herring wrote:
> >>
> >> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
> >>>
> >>> + more DT maintainers folks
> >>>
> >>> Hi all,
> >>>
> >>> I know this is mostly boring user space code, but I was expecting a
> >>> little bit of comments about at least the bindings syntax:-(
> >>>
> >>> I'd like to know if this is the right direction and if it worth pursuing
> >>> in that direction.
> >>>
> >>> The idea was to have at least some base for further discussion during
> >>> ARM KS 2013.
> >>>
> >>> I feel alone :-(
> >>>
> >>> If you have any comment, go ahead!
> >>
> >>
> >> Thanks for taking this on!
> >>
> >> This is interesting approach using the dts syntax,
> >
> >
> > Well, this was discussed a little bit on the list, and it has the big
> > advantage of re-using the parser already included in DTC for free.
> > In term or readability, it avoids to re-defining a brand new syntax for
> > people who are already familiar with the DTS one.
> >
> >
> >> but I worry that the
> >> validation will only be as good as the schema written and the review of
> >> the schema.
> >
> >
> > Well, sure, but unfortunately, that will always be the case :-(
> > The bindings definition being quite open, there is no easy way to ensure
> > proper schema / bindings without careful review of the schema. There is no
> > such thing as a free beer... Unfortunately :-)
> >
> >
> >> I think the schema needs to define the binding rather than
> >> define the checks. Then the schema can feed the validation checks.
> >
> >
> >> This format does not seem to me as easily being able to generate
> >> documentation from the schema which I believe is one of the goals.
> >
> >
> > Indeed, but I think is it easy to generate any kind of readable format for
> > the documentation purpose if needed from the actual format.
> > Otherwise, we should consider a schema format based on kerneldoc type of
> > syntax to improve readability. I'm just afraid it will become harder then to
> > define complex schema.
> >
> > BTW, what kind of documentation are you expecting here? Is is a text that
> > can be added on top of each schema?
> 
> I would expect the schema to replace
> Documentation/devicetree/bindings/* over time. I think the thing that
> needs to be worked out here is how to add free form multi-line text.

I'm not convinced that's a realistic goal.  As I see it, the
fundamental difference between a binding document and a formal schema
is that a binding defines both the syntax required of a node, and its
semantics, whereas a schema defines only syntax - the semantics still
need to be defined somewhere.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/080a5fd4/attachment.sig>
