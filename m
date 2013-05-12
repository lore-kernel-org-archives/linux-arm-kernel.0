From: broonie@kernel.org (Mark Brown)
Date: Sun, 12 May 2013 18:33:44 +0400
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <7e18bed3-ae6b-4aa0-bf23-b6c61ba8b85b@CO9EHSMHS030.ehs.local>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130510212422.GY3200@sirena.org.uk>
 <7e18bed3-ae6b-4aa0-bf23-b6c61ba8b85b@CO9EHSMHS030.ehs.local>
Message-ID: <20130512143344.GC3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 09:54:22AM -0700, S?ren Brinkmann wrote:
> On Fri, May 10, 2013 at 10:24:22PM +0100, Mark Brown wrote:

> > For your use case should these things be exposed by the FPGA device
> > asking for that rather than by having the clocks available separately?
> > Or is this part of the DT blob that's loaded incrementally along with
> > the FPGA (which does make things more interesting of course...).

> Here may be some misunderstanding.
> The clocks are not in the FPGA. The clocks are always there and part of
> the processing system (PS), they are just routed to the FPGA where they
> can be used as clocks for the FPGA design.

No, there's no confusion here - the clocks that are being exposed to
userspace are the clocks which enter the FPGA.  The driver or whatever
that understands the FPGA can do what is needed to control them,
including routing them on to subdevices it instantiates or exposing them
to userspace.

> > > +		clk_disable_unprepare(pdata->clk);
> > 
> > > +	if (ret)
> > > +		return -EBUSY;
> > 
> > Why not pass back the actual error?

> Good question. Was there some spec saying, that these sysfs callbacks
> should return this error? Otherwise this will be fixed.

Not to my knowledge.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130512/e5bcf26c/attachment.sig>
