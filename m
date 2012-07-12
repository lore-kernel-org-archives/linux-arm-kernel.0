From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Jul 2012 18:15:29 +0100
Subject: Device tree binding for DVFS table
In-Reply-To: <20120712171016.GL2772@gmail.com>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
 <20120711200402.GC2772@gmail.com>
 <20120712141001.GE9437@tbergstrom-lnx.Nvidia.com>
 <20120712171016.GL2772@gmail.com>
Message-ID: <20120712171528.GK7256@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 10:10:16AM -0700, Mike Turquette wrote:
> On 20120712-17:10, Peter De Schrijver wrote:

> > + power rail constraints (eg voltage difference limit between 2 rails)

> This should come from regulator DT data and not anything DVFS-specific,
> correct?

Currently the regulator API will only constrain individual rails (and
shortly likely parent/child relationships).  It will not do anything to
constrain between different rails, this has been left to the consumers.
For this stuff it may still make sense to do that if we've got a set of
operating points defined which apply over multiple inputs (like clock
and frequency) - we'll naturally impose these constraints by virtue of
selecting the operating point.

> > + clock constraints (eg. clock x frequency must be a fixed ratio of clock y
> >   frequency)

> Yeah, after sending my email above yesterday I instantly regretted it.
> It is true that *functional* clock dependencies are really the purview
> of the device driver.  E.g. for Device X to operate at FAST_SPEED, scale
> functional_clk up to 200MHz and l3_ddr_clk up to 100MHz.  On OMAP our
> display subsystem block also has clock ratio rules that must be honored,
> but it just open-coded.

This is similar to the regulator thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/161e4acc/attachment.sig>
