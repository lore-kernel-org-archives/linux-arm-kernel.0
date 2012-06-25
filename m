From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 25 Jun 2012 13:07:45 +0200
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <27366523.LjLfRK1TqH@ax5200p>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4127323.noaajNecru@ax5200p>
 <20120624123151.GZ4037@opensource.wolfsonmicro.com>
 <27366523.LjLfRK1TqH@ax5200p>
Message-ID: <20120625110745.GB11710@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2012 at 03:27:42PM +0200, Marc Dietrich wrote:
> On Sunday 24 June 2012 13:31:51 Mark Brown wrote:
> > On Sun, Jun 24, 2012 at 02:01:58PM +0200, Marc Dietrich wrote:
> > > On Sunday 24 June 2012 12:03:06 Mark Brown wrote:
> > > > > > +                                 	regulator-name = "+3.3vs_ldo0";
> > > > > > +					regulator-max-microvolt = <3300000>;
> > > > 
> > > > This is one example, it looks like the rail needs to be fixed to 3.3V.
> > > 
> > > I think nowhere in the code a regulator (beside sm*) is programmed to some
> > > different value that the maximum given here (this is not the maximum the
> > > regulator can provide). I never understood why the kernel code always sets
> > > the regulator to the maximum value if no other value was specified. IMHO,
> > > there should be some initial value, e.g. regulator-default-microvolt, as
> > > the original driver (from 2.6.32 ages) did. This way the maximum value
> > > can be set
> > That's *never* been in mainline, and nobody even bothered trying to
> > submit it.
> 
> which was the best thing to do ;-)
> 
> > > to the hw limits, but maybe this is a bit dangerous.
> > 
> > One of two things should be happening.  Either a single voltage is
> > specified (in which case that voltage will be configured in the
> 
> I'm not an expert on this, but it seems to me that only sm0 and sm1 should be 
> changeable (and some rail called vdd_aon, which seems to be ldo2 in case of 
> paz00 connected to the rtc). So, all others can be constant voltage. Maybe 
> Stephen can comment on the actual requirements (also for the other boards 
> which may have similar layout).

I can confirm that at least for ldo0 the value needs to be fixed. I did
in fact post a patch back in February that was needed to fix PCIe on
Harmony. I also sat down with one of our hardware engineers and worked
through the list and wrote down the requirements for Harmony. I need to
check where our notes have gone, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/954f8773/attachment.sig>
