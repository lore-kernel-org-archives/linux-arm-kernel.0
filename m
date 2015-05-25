From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 25 May 2015 18:56:58 +0200 (CEST)
Subject: [PATCH] clockevents: don't suspend/resume if unused
In-Reply-To: <20150116165914.GS3843@piout.net>
References: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150116092014.GA27945@gradator.net> <20150116165914.GS3843@piout.net>
Message-ID: <alpine.DEB.2.11.1505251854380.5457@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jan 2015, Alexandre Belloni wrote:
> Hi,
> 
> On 16/01/2015 at 10:20:14 +0100, Sylvain Rochet wrote :
> > > +		if (dev->suspend && dev->mode != CLOCK_EVT_MODE_UNUSED)
> > 
> > I wonder if we should use > CLOCK_EVT_MODE_SHUTDOWN
> > (or CLOCK_EVT_MODE_UNUSED || CLOCK_EVT_MODE_SHUTDOWN) instead of 
> > !CLOCK_EVT_MODE_UNUSED.
> > 
> 
> I'll let Thomas or Daniel decide :) But I'm open to that.

I'm unsure about the shutdown part. shutdown can be an intermediate
state where its not a given, that the clocks are disabled. I pick it
up as is.

Thanks,

	tglx
