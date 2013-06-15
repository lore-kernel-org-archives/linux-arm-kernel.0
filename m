From: balbi@ti.com (Felipe Balbi)
Date: Sat, 15 Jun 2013 18:05:01 +0300
Subject: [PATCH 2/2] ARM: dts: add AM33XX MMC support
In-Reply-To: <CAD=GYpYfMAZeV1RUC=DqhYGZaKiiukpTZg7bhO582eKwimS9aA@mail.gmail.com>
References: <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
 <20130307150408.GU6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20D27@DBDE01.ent.ti.com>
 <20130307160236.GV6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
 <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
 <20130614222537.GA25428@arwen.pp.htv.fi>
 <CAD=GYpYfMAZeV1RUC=DqhYGZaKiiukpTZg7bhO582eKwimS9aA@mail.gmail.com>
Message-ID: <20130615150500.GA27629@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 14, 2013 at 06:43:51PM -0500, Joel A Fernandes wrote:
> > > >> I just doublechecked MMC rootfs on bone and evmsk as it's the standard
> > > >> smoke test. My EVM is intermittent now so trying to coax it to power
> > up
> > > >> to reverify.
> > > >>
> > > >
> > > > Matt,
> > > >
> > > > Your branch is working for me, I tested it on EVM. Not sure what is
> > wrong with manual rebasing
> > > > I did yesterday. I will try to nail-down root-cause here.
> > > >
> > > > And you can submit the next version fixing the comments I have given.
> > >
> > > The only comment I could find in the whole discussion was adding of
> > > the interrupts property. I tested I don't have any problem booting
> > > with Matt's patch, without having the interrupts property.
> >
> > might very well be, but we want to figure out why adding "intrrupts"
> > causes issues. Why does it have to come through hwmod ? You might have
> > uncovered a real problem which needs fixing. Besides, at the end of the
> 
> 
> No actually I think I wasn't very descriptive in my post. There is no
> problem here. Whether it comes from DT or not, it works in both cases . (I
> haven't tried adding interrupt node to dts but what I gathered from
> Vaibhav's post is that it works also when added to dts)
> 
> But I can revisit Vaibhav's suggestion of adding it to dts for completeness
> sake. My tree currently works and picks up the interrupt info from hwmod. I
> just didn't see any activity on this thread for a while so I thought of
> enquiring it was ok to pull it in for the 3.11 merge window or if the
> consensus was that interrupt node be added to dts even though it works
> without it.

fair enough, then let's just add those interrupts to hwmod which will,
eventually, let us drop all of that data from hwmod.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130615/470afe0b/attachment.sig>
