From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Oct 2010 09:41:06 -0700
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <20101028163518.GG3122@n2100.arm.linux.org.uk>
References: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
	<20101027221428.GB28391@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010272227380.31220@xanadu.home>
	<1288283413.2683.2.camel@c-dwalke-linux.qualcomm.com>
	<20101028163518.GG3122@n2100.arm.linux.org.uk>
Message-ID: <1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-28 at 17:35 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 28, 2010 at 09:30:13AM -0700, Daniel Walker wrote:
> > On Wed, 2010-10-27 at 22:30 -0400, Nicolas Pitre wrote:
> > > On Wed, 27 Oct 2010, Russell King - ARM Linux wrote:
> > > 
> > > > > +#else
> > > > > +	.macro	addruart, rx, tmp
> > > > 
> > > > addruart is now expected to return two values, and 'tmp' ends up being
> > > > misleading.  This is a recipe for mistakes unless this is corrected.
> > > > It should be 'rp, rv' instead of 'rx, tmp'.
> > > 
> > > Also, it is probably not a good idea to return nothing. Otherwise the 
> > > code using those macros will then work on random values that just 
> > > happened to be in the corresponding register at the call location.
> > 
> > Should we have something in generic arm code that allows this to just be
> > turned off? Ideally we don't want any of this stuff even running.
> 
> If you don't want it, don't enable DEBUG_LL.  DEBUG_LL is what you
> enable for initial board bring-up and once you're getting kernel
> messages via standard console drivers, you disable it.

This board doesn't have the ability to support DEBUG_LL .. I don't want
the user to have the option to even select that.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
