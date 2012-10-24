From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Oct 2012 16:27:30 +0100
Subject: Possible regression in arm/io.h
In-Reply-To: <CABYn4sxnwzj8KFfELzCLzQMcAjiqS3_Vr2kStkm-na8G1noPHA@mail.gmail.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
 <CABYn4swp9JBEHgGTOkoe=tOh3Mf1dq5WYr=2xuKNpTmLX5LcFQ@mail.gmail.com>
 <20121024130957.GB7339@mudshark.cambridge.arm.com>
 <CABYn4sz4v7Uf07am=MtPAKAvvAjwt+-bTRaLrBjoiRuyR9cfZw@mail.gmail.com>
 <20121024135854.GD7339@mudshark.cambridge.arm.com>
 <CABYn4sxnwzj8KFfELzCLzQMcAjiqS3_Vr2kStkm-na8G1noPHA@mail.gmail.com>
Message-ID: <20121024152730.GH7339@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 04:04:46PM +0100, Bastian Hecht wrote:
> >> > Ok, I'll have a look at the impact of moving exclusively to "Q" when I get a
> >> > chance. Which toolchain are you using?
> >>
> >> gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
> >> For a more verbose info take a look at the bug report link.
> >
> > Ok, thanks. One other thing you could try while I try to find a copy of that
> > toolchain is changing the "+" modifier to an "=", like I proposed in this
> > version of the patch:
> 
> So if alter it to fit to your patch scheme the result is:

Sorry, the change wasn't as trivial as I thought -- you have to reorder the
constraints because an output becomes an input for the load accessors. I
tried it myself and it doesn't fix the issue (I can reproduce it now).

Will
