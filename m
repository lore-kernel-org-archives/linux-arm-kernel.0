From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 15 Mar 2012 22:34:49 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120315142702.GL3138@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
Message-ID: <20120315143446.GC6065@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 02:27:03PM +0000, Mark Brown wrote:
> On Wed, Mar 14, 2012 at 06:00:41PM -0500, Timur Tabi wrote:
...
> > I'm sorry you're frustrated, but so am I.  I still don't understand why
> > the binding that I invented for the SSI driver isn't good enough for i.MX.
> >  The binding and the code was documented and approved a long time ago.
> > Why can't we keep the same binding on i.MX, to keep the code simpler?
> 
> The problem with your binding has always been, and continues to be, that
> it's based on the idea that there's one CODEC per SSI and that the CODEC
> is a simple appendage of that SSI.  There's no real real binding for the
> machine driver, it's just silently created by a single SSI port.  Really
> there's nothing new with this issue, there's always been this absence of
> a representation for the machine distinct from the individual devices it
> is built up from.
> 
> This means that when you get systems which have auxiliary devices (like
> most of the Wolfson reference boards which have a power amplifier for
> the sub speaker not connected to an SSI port) or that need to set up
> things like complex accessory detection mechanisms there's no real place
> in your binding to support those systems.  Things like the configuration
> of the input and output connections which the nVidia WM8903 drivers are
> able to do over multiple boards are another example.

Yes, we will have the exactly same thing for imx-sgtl5000 to be added
later.  The current imx-sgtl5000 driver just an initial support.

-- 
Regards,
Shawn
