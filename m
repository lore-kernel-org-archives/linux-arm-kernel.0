From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 30 Oct 2015 14:16:46 -0700
Subject: [PATCH v2 1/3] devicetree: mfd: Add binding for the TI LM3533
In-Reply-To: <CAL_Jsq+d+_JgiEfQpgD29AnD+bM7Nq94-5NTjK=LFHNg162UOw@mail.gmail.com>
References: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1445963373-27790-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151030184220.GJ4058@x1>
 <20151030194150.GD24668@usrtlx11787.corpusers.net>
 <CAL_Jsq+d+_JgiEfQpgD29AnD+bM7Nq94-5NTjK=LFHNg162UOw@mail.gmail.com>
Message-ID: <20151030211646.GE24668@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 30 Oct 13:18 PDT 2015, Rob Herring wrote:

> On Fri, Oct 30, 2015 at 2:41 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> > On Fri 30 Oct 11:42 PDT 2015, Lee Jones wrote:
> >
> > Rob, please see the discussion regarding ti,boost-freq-khz below. Should
> > we both specify unit at the same time as we use standard units? (This is
> > not the first time I have to change this back and forth)
> >
> >> On Tue, 27 Oct 2015, Bjorn Andersson wrote:
> >>
[..]
> > The ti,boost-low-freq from the bq25890 binding is the only other
> > property I can find that describes the same thing. So I'm not sure I
> > follow you here.
> >
> >> Perhaps we need to create a set of generic bindings.
> >>
> >> Also, we usually measure DT bindings in HZ, not kHz.
> 
> Surprisingly, there are not enough examples to draw much conclusion.
> 
> > I thought we had defined frequencies to be in HZ and HZ only, but then
> > Rob's comment that I need to actually specify the unit doesn't make any
> > sense.
> 
> I don't think we decided, but let's decide now. Go with Hz.
> 

+1

> Really, I first prefer the property name has units and second having
> standardized units. But if there is a common property without units, I
> prefer that even more.
> 

You can find this property in a variety of hardware, but I don't think
it would make much sense to define this single property in a common
place today.

This seems to be the first case where we specify the unit on one of
these properties though.

> > Do we want these properties in a standard unit or do we want them
> > specifying the unit? Having both seems excessive.
> 
> You mean "freq" would imply the units? No, we want the actual units in
> the property.
> 

You're right, frequency can be measured in other units than Hz, I can't
think of one that would be applicable here though.

Either way, I'll slap on a unit to the property name - Hz that is...

Thanks for your input.

Regards,
Bjorn
