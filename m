From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 31 Aug 2011 11:32:13 +0800
Subject: [PATCH 2/3] ARM: GIC: add gic_reinit() function to help ARM resume
In-Reply-To: <20110830154717.GD19359@S2100-06.ap.freescale.net>
References: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
	<1314690017-17590-3-git-send-email-shawn.guo@linaro.org>
	<4E5CFB13.8060008@gmail.com>
	<20110830154717.GD19359@S2100-06.ap.freescale.net>
Message-ID: <20110831033212.GB19795@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 11:47:18PM +0800, Shawn Guo wrote:
> On Tue, Aug 30, 2011 at 10:00:35AM -0500, Rob Herring wrote:
> > Shawn,
> > 
> > On 08/30/2011 02:40 AM, Shawn Guo wrote:
> > > If ARM core gets powered off during suspend, GIC controller has to be
> > > reinitialized by resume procedure.  This patch adds a helper function
> > > for resume procedure to reinitialize GIC.
> > 
> > Is re-initializing rather than save/restore registers the right thing to
> > do here? Won't you lose things like edge or level triggered settings?
> > It's always been fuzzy to what should be done with interrupt masks in
> > suspend. Is every driver expected to disable and re-enable their
> > interrupts or this should be maintained thru a suspend cycle?
> > 
> Good point.  As one of the series, I easily went for the re-initializing
> approach here, plus it is pretty easy to go.  With your reminding, I
> agree that for interrupt controller save/restore registers might be the
> right thing to do.
> 
Rob,

As we share the same goal between Highbank and i.MX6Q on this, I'm
wondering if you already have something for save/restore registers
approach.  Otherwise, I may give a try on that.  But I want to avoid
duplicated effort.

-- 
Regards,
Shawn
