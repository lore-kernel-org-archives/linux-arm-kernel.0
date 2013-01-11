From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Jan 2013 14:28:24 -0500 (EST)
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <50F059A4.4010107@ti.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
 <50F059A4.4010107@ti.com>
Message-ID: <alpine.LFD.2.02.1301111425020.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013, Santosh Shilimkar wrote:

> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > +		/*
> > +		 * Flush the local CPU cache.
> > +		 *
> > +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > +		 * a preliminary flush here for those CPUs.  At least, that's
> > +		 * the theory -- without the extra flush, Linux explodes on
> > +		 * RTSM (maybe not needed anymore, to be investigated).
> > +		 */
> This is expected if the entire code is not in one stack frame and the
> additional flush is needed to avoid possible stack corruption. This
> issue has been discussed in past on the list.

I missed that.  Do you have a reference or pointer handy?

What is strange is that this is 100% reproducible on RTSM while this 
apparently is not an issue on real hardware so far.


Nicolas
