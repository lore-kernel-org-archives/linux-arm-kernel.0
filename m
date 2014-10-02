From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 2 Oct 2014 10:30:14 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <CAMuHMdXQ8bWCyaLiyOBKQNhB4rJDHBUzHnNMCf7_sPBtR1AKVg@mail.gmail.com>
References: <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo> <20141001171704.GG4273@sirena.org.uk>
 <CAMuHMdXQ8bWCyaLiyOBKQNhB4rJDHBUzHnNMCf7_sPBtR1AKVg@mail.gmail.com>
Message-ID: <20141002083012.GC30167@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 08:43:27PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 1, 2014 at 7:17 PM, Mark Brown <broonie@kernel.org> wrote:
> >> Well, I don't think it should because it describes the same resources
> >> that the device tree node for the real device already describes. But
> >> perhaps this is one of the cases where duplication isn't all that bad?
> >
> > If we were worried about this wecould also do it by referring to
> > those nodes and saying "get all the resources these things need" rather
> > than duplicating the references (this might make it easier to work out
> > when the system is ready to hand off to the real drivers).
> 
> You can have a single node for both simplefb and the later "real" driver.
> DT describes the hardware, not the software ecosystem running on the
> hardware. Clock, regulators, etc. don't change from a hardware point of
> view.
> 
> If the firmware initialized a suitable graphics mode, it just has to add
> "linux,simplefb" to the compatible property (and perhaps a few other
> simplefb-specific properties).

Unfortunately I don't think that's going to work. Especially on ARM SoCs
there is no single node for a display device. The display device is
typically composed of several subdevices.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/2d4f759b/attachment.sig>
