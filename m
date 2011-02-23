From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 22 Feb 2011 22:21:21 -0500 (EST)
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <8ya8vx7jvqh.fsf@huya.qualcomm.com>
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
	<4D5DC289.1090004@codeaurora.org>
	<1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTi=0Pxg09x8DdVDVy9Ur7r1dgB+4LM3q0hM4_8Rg@mail.gmail.com>
	<1298419839.17118.5.camel@m0nster> <8ya62sbli3z.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1102222049410.22028@xanadu.home>
	<8ya8vx7jvqh.fsf@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1102222209350.22028@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Feb 2011, David Brown wrote:

> On Tue, Feb 22 2011, Nicolas Pitre wrote:
> 
> > And if someone else comes up with a SSBI interface, then it will be much 
> > easier to notice the already existing driver if it is in the driver 
> > directory rather than somewhere else in some unrelated (from that 
> > person's pov) obscure directory.
> 
> Well, I'm fairly sure that nobody would be making an SSBI interface, but
> point taken.

It's not necessarily the SSBI interface per se that is interesting to 
other people, but rather the fact that the code driving it might be 
relying upon generic kernel infrastructure, such as driver or bus 
registration, interrupt requests, resource allocation, etc.

> So what kinds of things constitute drivers versus arch-specific code?
> Currently, iommu drivers seem to be sprinkled throughout arch.

Yes, and so are clock source and clock event "drivers".  Some things 
fall into a gray area and this is not always clear what the proper 
location is for them.  But as a rule of thumb you should follow what 
most other people did, and if there is no example to follow then just go 
with drivers/msm/ by default which should be a pretty safe bet.


Nicolas
