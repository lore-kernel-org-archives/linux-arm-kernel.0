From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 14 Apr 2011 07:59:58 -0400 (EDT)
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110414103200.GF1611@n2100.arm.linux.org.uk>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104140751220.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Apr 2011, Russell King - ARM Linux wrote:

> On Thu, Apr 14, 2011 at 08:25:05PM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2011-04-14 at 11:00 +0100, Russell King - ARM Linux wrote:
> > > 
> > > I will take it, but at the moment I'm rather unhappy about the response
> > > from the community to Linus' complaint.
> > > 
> > > If existing platform maintainers can show that moving over to this will
> > > result in a net reduction of code under arch/arm, then that will be good.
> > > What I don't want to see at the moment is arch/arm increasing in size as
> > > a result of any change.  We desperately need to see a reduction for the
> > > next merge window.
> > 
> > It's a chicken and egg... platform maintainers wait for you to take it
> > and you wait for them to take it :-)
> > 
> > It seems to me that this fits well into the category of "better common
> > abstractions" that was discussed in the thread initiated by Linus as one
> > of the ways to improve on the "clutter"...
> 
> That depends - sometimes creating generic stuff results in a net increase
> in the overall size, and that's something that Linus also complained about.
> 
> According to linux-next, where we are at the moment with arch/arm is a
> net increase of 6000 lines since the close of the last merge window,
> and arch/arm is responsible for almost 75% of arch/ changes.  It looks
> very much like the same situation which Linus complained about.

Quoting Linus:

| Umm. The whole "number of lines of code" thing has become a total red
| herring.
| 
| THAT IS NOT WHY I STARTED TO COMPLAIN!
| 
| The reason I point out the number of lines of code is because it's one
| of the more obvious _symptoms_ of the problem.

So we need to work on infrastructure, and the clock API is exactly that.  
Obviously adding it will increase the number of lines of code initially, 
but eventually this will help _reduce_ them, and more importantly it 
will allow for the reduction of mindless duplication of code that was 
identified as being the actual problem causing maintenance pain.


Nicolas
