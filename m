From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Nov 2016 10:12:48 +0100
Subject: [PATCH v3 09/13] ARM: dts: armada-375: Fixup soc DT warning
In-Reply-To: <87d1htb1qr.fsf@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
 <20161117230830.31047-10-gregory.clement@free-electrons.com>
 <20161118095455.00bfe007@free-electrons.com>
 <87d1htb1qr.fsf@free-electrons.com>
Message-ID: <20161118101248.784eff2b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 18 Nov 2016 10:01:32 +0100, Gregory CLEMENT wrote:

> >> +	soc at f00100000000 {  
> >
> > Where is this value coming from? Why does the soc node needs to have a  
> 
> It cames from the dts files.

Where?

> > unit address? It doesn't have a 'reg' property if I remember
> > correctly.  
> 
> But it has a range property.

And? There are multiple ranges, and you randomly took the first one for
the unit address of the soc node?

You realize that the ranges property is a list of ranges, and they
could be in any order? Why would you pick the base address of one of
the ranges rather than any of the others?

I believe there is simply no unit address for the soc {} node. There is
definitely one for the internal-regs {} node, but not for the soc {}
node.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
