From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 10:49:48 -0700
Subject: [RFC PATCH v3 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <1371215040.3154.6.camel@hornet>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370512763-32200-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130613225233.GB22310@quad.lixom.net>
 <1371215040.3154.6.camel@hornet>
Message-ID: <20130614174948.GA15759@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 02:04:00PM +0100, Pawel Moll wrote:
> On Thu, 2013-06-13 at 23:52 +0100, Olof Johansson wrote:
> > > +     reg = <0 0x7FFF0000 0 0x1000>;
> > 
> > #size-cells 2 on the parent bus? That's somewhat unusual. 
> 
> LPAE == 40 bit physical addresses == potential > 32 bit sizes (memory
> blocks > 4GB)

Yeah, I guess that's most commonly needed for the /memory nodes -- having
devices with more than 4GB of register space is quite unusual.

It doesn't really matter much, but it saves some padding of 0s if you
pick a smaller value.

I thought we used 2/1 for address/size-cells on PA Semi hardware, but I just
checked and we had 2/2. Maybe it was Apple that used 2/1.

Anyway, no big deal.


-Olof
