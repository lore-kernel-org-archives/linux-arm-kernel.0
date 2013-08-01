From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 1 Aug 2013 15:29:20 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <20130731185947.GB9858@sirena.org.uk>
References: <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <20130730205716.GZ9858@sirena.org.uk>
 <CAKON4Ox7-6Jf0ce64Wqr5E49KS+9E135mqc_iG-PWQ7r8bzWHA@mail.gmail.com>
 <20130730230331.GC9858@sirena.org.uk>
 <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
 <20130731113401.GM9858@sirena.org.uk>
 <20130731165902.GA3329@localhost.localdomain>
 <20130731185947.GB9858@sirena.org.uk>
Message-ID: <20130801142915.GA3006@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 07:59:47PM +0100, Mark Brown wrote:
> On Wed, Jul 31, 2013 at 05:59:10PM +0100, Dave Martin wrote:
> 
> > There may often be a conflict between making _good_ bindings, and making
> > bindings which are convenient for maintainers to edit in .dts syntax.
> 
> > I think good bindings (in the sense of good ABI) must take precedence:
> > good bindings need to interoperate well over a long period of time, and
> > should be robust against future evolution of hardware platforms OSes.  If
> > they look nice in the .dts file, that's a bonus -- but I don't think it
> > should be viewed as a requirement.
> 
> While I take your point that we need to have a sane ABI I think you're
> understating the importance of the human factors here - the harder it is
> to reliably understand and edit the device trees the more likely it is
> that people will end up shipping mistakes which undermines the work on
> defining stable ABIs.
> 
> > A pair of properties like dma-names/dmas may be a bit cumbersome, but
> > it can be precise, unambiguous, and simple and easy to parse and check.
> > The semantics can be extended in the future if necessary, by adding
> > additional companion properties.  From my perspective, this can work as
> > a template for good bindings.
> 
> I think this is fine for bindings but it's just not really legible for
> humans once the lists start growing.  We need a human interaction format
> which is suitable for humans to work with, it's not good when people
> start finding that it's a set backwards in terms of their ability to
> work with their systems.
> 
> > Someone trying to maintain a complex .dts can always make their own life
> > easier with a bit of scripting.  After all, in a future of stable
> > bindings, a DT really shouldn't be changing much once it is complete.
> > I don't see a clear reason why these issues must be solved by dtc
> > itself.
> 
> I don't think it's terribly important if they're solved in dtc itself so
> long as it's part of the standard tooling that everyone has access to.
> There's a reasonable number of new SoCs get made which tend to be the
> things that suffer most.

I agree with your points -- I just wanted to make the point that extensions
to .dts must be considered carefully, focusing on a few key features
that really are useful to everyone -- and with a commitment to support
and use those features.
 
If we start making ad-hoc extensions, I worry that there is a risk of
dtc forking -- has this issue been discussed?  How do we avoid that
situation?


A fork in dtc and .dts might not be so bad a problem as a fork in the
FDT format or DT bindings themselves, but it still sounds best avoided.
A Linux- or ARM-specific dtc would be just as bad as vanilla dtc plus an
obscure preprocessing framework that only the Linux (or ARM) folks use.


If we agree that the only acceptable form for "object-like" properties is
the paired-property model and enforce/strongly encourage this policy
when reviewing new bindings, then it may be worth adding dedicated
syntax to dtc.  We just shouldn't allow this tool to morph into dt-c++
unless we have a relly good reason.

Cheers
---Dave
