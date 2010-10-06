From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 06 Oct 2010 09:05:28 +0200
Subject: [PATCH v3 4/5] mfd: regulator: max8998: voltages and GPIOs defined
	at platform data structure
In-Reply-To: <1286186989.3148.19.camel@odin>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
	<1285590747-32404-5-git-send-email-l.majewski@samsung.com>
	<20100927184336.GK2560@sortiz-mobl> <1286026413.3125.27.camel@odin>
	<20101004084646.4de3714d@lmajewski.digital.local>
	<1286186989.3148.19.camel@odin>
Message-ID: <015e01cb6524$de617cb0$9b247610$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, October 04, 2010 12:10 PM Liam Girdwood wrote:

> On Mon, 2010-10-04 at 08:46 +0200, Lukasz Majewski wrote:
> > On Sat, 02 Oct 2010 14:33:33 +0100
> > Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> >
> > > On Mon, 2010-09-27 at 20:43 +0200, Samuel Ortiz wrote:
> > > > Hi Lukasz,
> > > >
> > > > On Mon, Sep 27, 2010 at 02:32:26PM +0200, Lukasz Majewski wrote:
> > > > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > > Fine with me:
> > > > Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> > > >
> > >
> > > Lukasz, this is not applying against the regulator next tree.
> > > Can you redo and add Mark and Samuels Acks.
> > >
> > > Thanks
> > >
> > > Liam
> >
> > Hi Liam,
> >
> > I've fetched the newest voltage-2.6/for-next and merge it with newest
> > mfd-2.6/for next. After that all patches are applying and kernel is
> > building without errors.
> >
> > The problem with this patch series is that it "touches" two
> > repositories: voltage-2.6 and mfd-2.6.
> >
> > I'm a bit confused how such situation should be resolved, since it
> > involves two separate repositories (and two maintainers to cooperate).
> >
> You should only base your patches on one tree for upstreaming and since
> this series mostly touches regulator it's best base against the
> regulator tree.

Liam, the problem is the fact that there are 4 patches for max8998 mfd driver
already merged to mfd-next tree: 40d5c1f412cf166c0cd87b0f6eb7fed70a2b9e05,
128f9848ed5d3b09dc8f6f5cdc19eed48b879ccf, ec2465481c6da42766046cd2307edc46908d645b
and be9be9dcf14947fc6ad99e5df0eb3d6e09aaedca. At least the first two are required
for the patches that has been prepared by Lukasz. Removing the dependency on these
2 commits from Lukasz's patches is pointless, because such version will conflict
with these patches from mfd-next tree.

I'm a bit confused how this case should be handled. I see two solutions:
1. importing these 4 max8998 patches from mfd-next to regulator-next tree 
   (cherry-picking from mfd-next to regulator-next or git pull the whole tree)
2. splitting patches for 2 different sets (one set for mfd tree, second for
   regulator tree)

The second option has a serious drawback however. Regulator part from Lukasz's
patches will not even compile until the mfd part has been merged.

Liam, Samuel, could you both comment on this issue?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
