From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Mar 2013 10:57:17 +0900
Subject: [PATCH v4 2/3] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <CAOesGMhGE25gjgdPp-FfCSA57=+SX_2xcry9s=Ln5n5ZbWsU9Q@mail.gmail.com>
References: <201302272339.15402.sergei.shtylyov@cogentembedded.com>
 <20130301014148.GB9232@quad.lixom.net>
 <20130301072345.GD14376@verge.net.au>
 <20130305002653.GA9439@verge.net.au>
 <CAOesGMhGE25gjgdPp-FfCSA57=+SX_2xcry9s=Ln5n5ZbWsU9Q@mail.gmail.com>
Message-ID: <20130305015717.GG16128@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 05:05:35PM -0800, Olof Johansson wrote:
> On Mon, Mar 4, 2013 at 4:26 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Mar 01, 2013 at 04:23:45PM +0900, Simon Horman wrote:
> >> On Thu, Feb 28, 2013 at 05:41:48PM -0800, Olof Johansson wrote:
> >> > On Wed, Feb 27, 2013 at 11:39:14PM +0300, Sergei Shtylyov wrote:
> >> > > From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >> > >
> >> > > Add SATA clock for r8a7779 SoC (for both device tree and usual cases).
> >> > > Register SATA controller as a "late" platform device on r8a7779 SoC.
> >> >
> >> > Hi,
> >> >
> >> > If you have the a binding in the device tree (which you do through patch 1/3),
> >> > then there's no reason to have a platform device for it.
> >>
> >> Hi Olof,
> >>
> >> the DT exists but currently the marzen board brings up all
> >> of its devices using platform devices. Which if nothing else is
> >> internally consistent.
> >>
> >> I suppose it would be possible to add a call to
> >> r8a7779_add_standard_devices_dt() and have the board bring
> >> up this device using DT and the rest using platform drivers
> >> (until the drivers are migrated to DT).
> >>
> >> Would that be your preferred option?
> >>
> >> Magnus, how do you feel about this idea?
> >
> > Ping.
> 
> Sorry, I know the ping wasn't directed at me, but I didn't reply yet either. :)
> 
> This is generally the right migration model for platforms that have
> some regular platform devices today; register what isn't yet DT
> enabled through the old ways, but also probe device tree for the
> devices that are described there.
> 
> You might need AUXDATA tables to get clock names right (since device
> names are different) until you have clock bindings, that's what other
> platforms have done as well. Over time you can migrate away from it
> and switch to only DT.

Thanks. Unless Magnus has an objection I will make it so.
