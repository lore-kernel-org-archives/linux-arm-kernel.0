From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 22 May 2012 14:15:32 +0300
Subject: Clock register in early init
In-Reply-To: <CAJOA=zNoj1nZ+zVURfhziqFem4F7_Y_B8s=Gp1Aptr0hgfj6Xw@mail.gmail.com>
References: <1337227884.2066.9.camel@pgaikwad-dt2>
 <20120517062131.GA9305@gmail.com>
 <1337316517.22560.19.camel@pgaikwad-dt2>
 <20120518112104.GL20304@tbergstrom-lnx.Nvidia.com>
 <CAJOA=zM_o1Nqw55xxFvw6KssM50Q+7yyo41rUSH2Aoo1neTMjg@mail.gmail.com>
 <20120521084642.GV20304@tbergstrom-lnx.Nvidia.com>
 <CAJOA=zNoj1nZ+zVURfhziqFem4F7_Y_B8s=Gp1Aptr0hgfj6Xw@mail.gmail.com>
Message-ID: <20120522111532.GH8730@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 08:05:57PM +0200, Turquette, Mike wrote:
> On Mon, May 21, 2012 at 1:46 AM, Peter De Schrijver
> <pdeschrijver@nvidia.com> wrote:
> >>
> >> On OMAP I think the only "gotcha" is setting up the timer. ?One
> >> solution is to open code the register reads and the rate calculation
> >> in the timer code. ?That is ugly... but it works.
> >>
> >> > Which advantages do you see in dynamically allocating all this?
> >> >
> >>
> >> There are many but I'll name a couple. ?The most significant point is
> >> that we can avoid exposing the definition of struct clk if we
> >> dynamically allocate stuff. ?One can use struct clk_hw_init to
> >> statically initialize data, or instead rely on direct calls to
> >> clk_register with a bunch of parameters.
> >>
> >
> > Which means if you make a mistake in specifying parents for example, it will
> > only fail at runtime, possibly before any console is active. With static
> > initialization, this will fail at compiletime. Much easier to debug.
> >
> 
> Is this really a problem?  Once you have good data it does not change.
>  Debugging bad data when introducing a new chip is just a fact of
> life.  Static versus dynamic is irrelevant here.
> 

I think it is a problem yes, especially when the tree becomes more
complicated.

Cheers,

Peter.
