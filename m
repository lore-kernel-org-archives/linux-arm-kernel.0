From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Oct 2010 23:28:44 +0100
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <1288390882.6631.16.camel@m0nster>
References: <20101028174653.GH3122@n2100.arm.linux.org.uk>
	<1288288824.2683.24.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010281422190.3227@xanadu.home>
	<20101028182851.GI3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010281441540.3227@xanadu.home>
	<20101028184627.GK3122@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010282226460.5029@xanadu.home>
	<1288387033.6631.13.camel@m0nster>
	<20101029221437.GA31224@n2100.arm.linux.org.uk>
	<1288390882.6631.16.camel@m0nster>
Message-ID: <20101029222844.GB31224@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 29, 2010 at 03:21:22PM -0700, Daniel Walker wrote:
> On Fri, 2010-10-29 at 23:14 +0100, Russell King - ARM Linux wrote:
> 
> > Your original patch is unsuitable as it leaves the values uninitialized.
> > 
> 
> All I'm really concerned about is fixing the build issue during this
> merge window. But I'll send another patch with your suggestions added.

As we have had a complaint from Linus about pointless churn, and this
approach causes unnecessary churn, I will refuse to apply this.  Fix
the thing properly (it's not hard) or don't bother trying to fix it at
all.

All you need do is to use your initial patch, but change the addruart to
the following:

	.macro	addruart, rp, rv
	mov	rv, #0xff000000
	orr	rv, rv, #0x00f00000
	.endm

and you commit the result.  Problem fixed in one go, both from the
compile point of view _and_ the runtime point of view.  It's really
not difficult.
