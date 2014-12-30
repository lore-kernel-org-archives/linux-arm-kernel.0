From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 30 Dec 2014 10:12:59 -0500
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <20141222112933.GK19261@kw.sim.vm.gnt>
References: <20141218191528.GY967@titan.lakedaemon.net>
 <549437DD.7040602@free-electrons.com>
 <20141219160230.GZ967@titan.lakedaemon.net>
 <54944DAC.1000709@free-electrons.com>
 <20141219170328.GA967@titan.lakedaemon.net>
 <54945C5C.2080801@free-electrons.com>
 <20141219174300.GB967@titan.lakedaemon.net>
 <20141219181616.GG19261@kw.sim.vm.gnt>
 <20141221235000.GC28117@titan.lakedaemon.net>
 <20141222112933.GK19261@kw.sim.vm.gnt>
Message-ID: <20141230151259.GI28117@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 12:29:33PM +0100, Simon Guinot wrote:
> On Sun, Dec 21, 2014 at 06:50:00PM -0500, Jason Cooper wrote:
> > On Fri, Dec 19, 2014 at 07:16:16PM +0100, Simon Guinot wrote:
> > > On Fri, Dec 19, 2014 at 12:43:00PM -0500, Jason Cooper wrote:
> > > > On Fri, Dec 19, 2014 at 06:11:56PM +0100, Gregory CLEMENT wrote:
> > > > > On 19/12/2014 18:03, Jason Cooper wrote:
> > > > > > On Fri, Dec 19, 2014 at 05:09:16PM +0100, Gregory CLEMENT wrote:
> > > > > >> On 19/12/2014 17:02, Jason Cooper wrote:
> > > > > >>> On Fri, Dec 19, 2014 at 03:36:13PM +0100, Gregory CLEMENT wrote:
> > > > > >>>> On 18/12/2014 20:15, Jason Cooper wrote:
> > > > > >>>>> On Thu, Dec 18, 2014 at 06:15:40PM +0100, Gregory CLEMENT wrote:
> > > > > >>>>> ...
> > > > > >>>>>> Jason at the end it seems you didn't ack or nack the patches were you
> > > > > >>>>>> were CC. You expressed some concerns about the GPLv2+ move but I don't know
> > > > > >>>>>> if it is something that prevents you to give your acked-by.
> > > > > >>>>>
> > > > > >>>>> Oops.  :)  I figured my S-o-B when applying would be sufficient.  That
> > > > > >>>>> decision was before we decided on Andrew applying patches this time
> > > > > >>>>> around...
> > > > > >>>>>
> > > > > >>>>> For all my dts{i} contributions:
> > > > > >>>>>
> > > > > >>>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
> > > > > >>>>
> > > > > >>>> Thanks :)
> > > > > >>>>
> > > > > >>>>>
> > > > > >>>>> Due to all the merge commits over time and whatnot, it's probably best
> > > > > >>>>> to put my Ack on all the patches in this series...
> > > > > >>>>
> > > > > >>>> OK no problem. By the way, I take care of collecting all the acked-by and
> > > > > >>>> once it will be done I will either sent the updated patch set with all the
> > > > > >>>> acked-by or maybe just I will create a branch to pull if it is easier to handle.
> > > > > >>>
> > > > > >>> Ok, that'll be up to Andrew.
> > > > > >>>
> > > > > >>> Once we have the last few stragglers, and assuming there are no more
> > > > > >>> NAKs, here's what I'd like to do:
> > > > > >>>
> > > > > >>> Regrettably, we'll have to revert Simon's dts contributions.  I say
> > > > > >>
> > > > > >> You missed the email he sent yesterday, finally Simon changed his mind
> > > > > >> and gave his acked-by.
> > > > > > 
> > > > > > Indeed, that was for the oneliner change in the armada-370-xp.dtsi file.
> > > > > > I got a bit ahead of myself, but I'm looking towards kirkwood, orion5x,
> > > > > > dove, which brings up:
> > > > > > 
> > > > > > 18ba7e4fe51d ARM: Kirkwood: add DT support for d2 Network v2
> > > > > > 2d4cd2cafaea ARM: Kirkwood: allow to use netxbig DTSI for d2net_v2 DTS
> > > > > > a96cc303e42a ARM: mvebu: update the SATA compatible string for Armada 370/XP
> > > > > > d3dde4df4483 ARM: Kirkwood: update Network Space Mini v2 description
> > > > > > 98d4f2acb91a ARM: Kirkwood: DT board setup for CloudBox
> > > > > > 4ea931e07d77 ARM: Kirkwood: fix ns2 gpios by converting to pinctrl
> > > > > > 7f9871d9d30f ARM: kirkwood: DT board setup for Network Space Mini v2
> > > > > > ca7d94524ab3 ARM: kirkwood: DT board setup for Network Space Lite v2
> > > > > > ecee1e47ab42 ARM: kirkwood: DT board setup for Network Space v2 and parents
> > > > > > 
> > > > > 
> > > > > OK I understand your concern now. About dove and kirkwood, did you notice that
> > > > > some files didn't have any license?
> > > > 
> > > > Yes.
> > > > 
> > > > > Especially none of the dove files have a license.
> > > > 
> > > > Yes, we'll cross that bridge when we get there.  I suspect it then falls
> > > > under the over-arching license of the project.  Regardless, we'll still
> > > > need Acks from all contributors.
> > > 
> > > Hi Jason,
> > > 
> > > What is the problem with keeping the LaCie DTS files under GPLv2+ only ?
> > 
> > Converting armada-* to dual license is just a small part of the
> > overarching effort to convert *all* the devicetree files to dual
> > license.  So, eventually, we'll be doing the same with kirkwood, dove
> > and orion5x dts{i} files.  Perhaps even during this merge window.
> > 
> > In the long term, we're attempting to provide one neutral place [1] for
> > the bootloaders and kernels to pull devicetrees from and contribute
> > changes back to.
> 
> OK, let's see if I understand correctly.
> 
> If I don't agree with the GPLv2+/x11 relicensing, then support for
> almost all the LaCie boards will be removed from the Linux kernel (maybe
> during the next merge window) ? Is that correct ?

No.  Nothing will change wrt to the Linux kernel.  In my mind, I've
always viewed arch/arm/boot/dts as a separate repo that happens to be
incubating in the Linux kernel tree.  Right or wrong, I was referring to
the dts/dtsi/bindings eventually standing on their own.  Looking back on
the conversation, I definitely worded it badly.  I apologize for that.

> Is there any way we can keep the LaCie DTS files licenced under GPLv2+
> _and_ still distributed with the others. Anyone would be free to choose
> to use them (or not), in respect of the licence terms.

Yes, the difficulty lies in making that distribution *easy* for other
projects.  They already have their own dts files, why would they adopt
our work if they have to pick through it?

I suspect the eventual solution (after the dts/bindings are their own
repo) will involve adopting the SPDX-* header tag, and then some
scripting to create separate git branches by license.  That would allow
us to keep everything in the repo, make it easy to incorporate /
redistribute based on license, and hopefully reduce the maintenance
burden.

thx,

Jason.
