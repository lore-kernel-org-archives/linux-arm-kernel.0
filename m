From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 03 Nov 2010 16:17:15 -0700
Subject: [PATCHv2 1/3] ARM: Translate delay.S into (mostly) C
In-Reply-To: <4CD1ECF7.5030105@codeaurora.org>
References: <1288300770-18350-1-git-send-email-sboyd@codeaurora.org>
	<1288300770-18350-2-git-send-email-sboyd@codeaurora.org>
	<1288808841.23615.5.camel@e102144-lin.cambridge.arm.com>
	<4CD1ECF7.5030105@codeaurora.org>
Message-ID: <1288826235.16859.38.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-03 at 16:15 -0700, Stephen Boyd wrote:
> On 11/03/2010 11:27 AM, Will Deacon wrote:
> > Hi Stephen,
> >
> > On Thu, 2010-10-28 at 21:19 +0000, Stephen Boyd wrote:
> >> Nico expressed concern that fixed lpj cmdlines will break due to
> >> compiler optimizations. That doesn't seem to be the case since
> >> before and after this patch I get the same lpj value when running
> >> my CPU at 19.2 MHz. That should be sufficiently slow enough to
> >> cover any machine running Linux.
> >
> > I appreciate this is an exceptional case, but there are some lucky
> > guys at ARM who (as routinely as they can) boot Linux on sub 1MHz
> > hardware. The delay loop is something they're keen to avoid so they do
> > make use of the lpj= command line option and would rather it didn't
> > break on them.
> 
> Do you know if it breaks at that frequency? I don't have any hardware to
> test with that goes lower than the stated 19.2 MHz.

Isn't it possible that a new compiler could optimize the code
differently, and then end up breaking lpj= ?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
