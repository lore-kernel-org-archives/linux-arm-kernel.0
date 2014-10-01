From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 1 Oct 2014 10:17:22 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140930180036.GI4273@sirena.org.uk>
References: <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
Message-ID: <20141001081721.GD18463@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 07:00:36PM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 08:03:14AM +0200, Thierry Reding wrote:
[...]
> > Of course as Geert pointed out in another subthread, taking this all the
> > way means that we have to disable all power management because the
> > firmware device may be sharing resources with other devices and which
> > therefore are not unused. That's a pretty strong argument and I don't
> > have a solution for that. It is only really a problem for cases where
> > the firmware virtual device isn't taken over by a proper driver at some
> > point, though.
> 
> Indeed, and we also run into trouble for things where we actually need
> to really turn off the resource for some reason (MMC has some needs here
> for example).

Perhaps an alternative would be to just keep power management going and
hope for the best. This may turn out not to be as much of a problem for
many SoCs or boards as people make it out to be.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/22e0c1c8/attachment.sig>
