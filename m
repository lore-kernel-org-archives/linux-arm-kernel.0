From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 12 Sep 2011 13:16:31 -0600
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <20110908064834.GL8148@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
	<1711465.COqYbTSZES@wuerfel>
	<20110907060501.GE8148@S2100-06.ap.freescale.net>
	<CAGsJ_4zF0hPKmYYETPGEgHHeyZUfjPUFkrTk--yPuuNy_M=DJA@mail.gmail.com>
	<20110908064834.GL8148@S2100-06.ap.freescale.net>
Message-ID: <20110912191631.GA23345@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 02:48:35PM +0800, Shawn Guo wrote:
> On Wed, Sep 07, 2011 at 08:43:06PM +0800, Barry Song wrote:
> > auxdata is really a temp solution, it really brings many details to
> > kernel, which should not be in kernel at all.
> > 
> The auxdata was originally designed to be a temp solution.  But we
> will see if it's really temp, considering it could also be used to
> carry platform callbacks and attach device id.  There are some other
> cases beside clock lookup that we have not been able to sort out just
> by device tree and will probably have to use auxdata as well.

auxdata is indeed intended to be a temporary solution, and it is an
absolute requirement that board ports migrate away from it as soon as
feasible (ie. when needed infrastructure for clk, etc, become
available).

However, I don't expect auxdata to ever be completely removed.  There
will always be a handful of boards that require something special to
be provided by board code.  In those cases, auxdata is a perfectly
acceptable solution.

g.
