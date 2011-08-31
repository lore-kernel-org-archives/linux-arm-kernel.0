From: will.deacon@arm.com (Will Deacon)
Date: Wed, 31 Aug 2011 20:35:25 +0100
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <4E5E7B35.9080008@gmail.com>
References: <20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>
	<1314798215.2344.76.camel@deneb.redhat.com>
	<20110831152137.GG8777@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108311332410.20358@xanadu.home>
	<20110831175147.GI8777@e102144-lin.cambridge.arm.com>
	<4E5E7B35.9080008@gmail.com>
Message-ID: <20110831193525.GA27476@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 07:19:33PM +0100, Rob Herring wrote:
> On 08/31/2011 12:51 PM, Will Deacon wrote:
> > Another thing that Marc and I tried on OMAP4 was not bringing up the secondary
> > CPU during boot (by commenting out most of smp_init). In this case, I/O
> > performance was good until we tried to online the secondary CPU. The online
> > failed but after that the I/O performance was certainly degraded.
> > 
> 
> Was the SCU enabled at that point? One diff between nosmp boot and
> offlining the 2nd core would be that the SCU remains enabled in the
> latter case. I think the SCU does not get enabled for nosmp.

Our rudimentary test (printing out the SCU control register during boot)
showed that it *was* enabled for nosmp. I think this is due to the secure
world having to do that on OMAP so it's probably not true for other
platforms.

Will
