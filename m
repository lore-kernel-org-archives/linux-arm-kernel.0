From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 04 Dec 2013 11:14:10 -0800
Subject: [PATCH v2 2/2] clk: add accuracy support for fixed clock
In-Reply-To: <20131202031558.GB29282@titan.lakedaemon.net>
References: <1385556285-19180-1-git-send-email-b.brezillon@overkiz.com>
 <1385556285-19180-3-git-send-email-b.brezillon@overkiz.com>
 <20131127145620.GR2879@titan.lakedaemon.net> <5296298C.9040300@overkiz.com>
 <20131127181042.16819.36364@quantum> <5296F8B2.9080807@overkiz.com>
 <20131202031558.GB29282@titan.lakedaemon.net>
Message-ID: <20131204191410.29850.32443@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jason Cooper (2013-12-01 19:15:58)
> On Thu, Nov 28, 2013 at 09:02:58AM +0100, boris brezillon wrote:
> > On 27/11/2013 19:10, Mike Turquette wrote:
> > >Quoting boris brezillon (2013-11-27 09:19:08)
> > >>>On Wed, Nov 27, 2013 at 01:44:45PM +0100, Boris BREZILLON wrote:
> ...
> > >>>I would also prefer to see an unknown accuracy be -1.
> > >>I decided to keep 0 as a default value for unimplemented recalc_accuracy
> > >>(or unspecified fixed accuracy) to keep existing implementation coherent.
> > >>
> > >>0 means the clk is perfect, and I thought it would be easier to handle a
> > >>perfect clk (even if this is not really the case) than handling an error
> > >>case.
> > >>
> > >>Another aspect is the propagation of the clk accuracy accross the clk tree.
> > >>Returning -1 in the middle of the clk chain will drop the previous clk
> > >>accuracy
> > >>calculation.
> > >>
> > >>Anyway, I can change this if you think this is more appropriate.
> > >What about the absence of the property?
> > >Instead of requiring a -1 value
> > >can we simply detect that the property does not exist? This is nicer for
> > >backwards compatibility with existing DTS.
> > 
> > I already handle the absence of the clock-accuracy property.
> > In this case the clock is considered perfect (accuracy = 0 ppb).
> 
> Yeah, in order to calculate the theoretical accuracy of a leaf node, a
> missing accuracy in the middle of the chain really derails things.
> Since my previous concern (modelling the real accuracy of the clocks) is
> not an issue here, I think assuming the absent accuracy is 0 is fine.
> Especially since all Boris is trying to do is avoid the RC clocks.

Agreed. If accuracy data must exist along the entire chain for the
calculation to be successful then the feature will be useless due to
lack of adoption of the accuracy data.

Regards,
Mike

> 
> thx,
> 
> Jason.
