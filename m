From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jul 2011 20:44:11 +0100
Subject: ARM cortex A9 feature
In-Reply-To: <CABi1daHh7cgyhJ4c3zo+jSUY4uzbFtihtgw0Q2Mcrndno_gcTA@mail.gmail.com>
References: <CAJ8eaTzLmSTSMOY-0Xg0tE-DEbZ6RNA+uh70Dn3K5CbrjQsEiA@mail.gmail.com>
	<CABi1daHh7cgyhJ4c3zo+jSUY4uzbFtihtgw0Q2Mcrndno_gcTA@mail.gmail.com>
Message-ID: <20110714194411.GA8942@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 09:56:34AM -0700, Dave Hylands wrote:
> Hi Naveen,
> 
> On Wed, Jul 13, 2011 at 11:26 PM, naveen yadav <yad.naveen@gmail.com> wrote:
> > Hi All,
> >
> > I am reading ARM cortex a9 manual and got few question in mind.
> >
> > 1. Where I need strong order type memory ? any sample example is very helpfull.
> 
> Often when dealing with hardware, you need to ensure that when your code does:
> 
> reg1 = val1;
> reg2 = val2;
> 
> that these writes actually occur in the order that the code issues
> them. Using volatile pointers will get the compiler to not reorder the
> instructions, but you still need the writes to hit the hardware in the
> same order that they were issued. Using strongly ordered memory is one
> way to achieve that.

Note that device memory also gives that an ordering guarantee too.
