From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jul 2014 09:05:26 -0400
Subject: [GIT PULL][for 3.17] pull request for hisilicon soc
In-Reply-To: <5326154.xHtqUP4l2C@wuerfel>
References: <53D1F2B0.1020603@hisilicon.com> <19341047.6Jx15lyPBg@wuerfel>
 <CAD6h2NRaR+JoAsQt_0uwP5hacqKzFnTUbqToGj6JfEyACoZc+A@mail.gmail.com>
 <5326154.xHtqUP4l2C@wuerfel>
Message-ID: <20140728130526.GM23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Marc,

On Mon, Jul 28, 2014 at 01:35:50PM +0200, Arnd Bergmann wrote:
> On Sunday 27 July 2014 09:57:22 Haojian Zhuang wrote:
> > On 26 July 2014 23:30, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Friday 25 July 2014 14:01:20 xuwei wrote:
> > >
> > >> ----------------------------------------------------------------
> > >> Haifeng Yan (3):
> > >>       ARM: debug: Rename Hi3716 to HI5XHD2
> > >
> > > This one had me confused for a while, because it seems like
> > > you are breaking support for hi3xxx, but instead it's just
> > > a different name for the same chip if I see this right.
> > >
> > > An easier approach would actually be to remove DEBUG_HI3716_UART
> > > completely: the setting is exactly the same for
> > > HI3716, HI3620 and HIX5HD2, so you can simply keep the name
> > > for the oldest chip here and change the help text to reflect
> > > which products it works on.
> > 
> > The physical address of hi3xxx uart is different from x5hd2.
> > 
> > Since hi3620 & hix5hd2 could be built into one image. If I don't use the
> > DEBUG_HIX5HD2_UART to mark, I can't distinguish the right UART
> > physical address only by ARCH_HI3xxx or ARCH_HIX5HD2.
> 
> Ah, you are right, I misread the source code. I saw that the
> virtual address is the same for both but didn't notice that
> the physical address is not.
> 
> So this patch is ok after all, please just clarify in the changelog
> that it is actually the same chip.
> 
> > > Finally, it's not clear why you need a new Kconfig symbol. It seems
> > > that all code you have is compiled independent of these, except for
> > > the dtb files and the DEBUG_LL setting.
> > >
> > 
> > Actually it's nearly same except for headsmp.S.
> > 
> > Hisilicon guys think that hix5hd2 belongs to another group. They don't
> > want to totally share their code base with hi3xxx.
> 
> This doesn't seem like a technical reason to me at all. I would
> much prefer if you and Xu Wei as maintainers were able to describe
> (in the changelog) the underlying technical reasons for decisions
> coming from management if it makes sense, or otherwise explain to
> them that we don't want those patches upstream if it doesn't make
> sense.
> 
> It's not a show-stopper this way, and I'd still pull the branches
> with this, but you should be aware that it does not help your
> reputation.
> 
> > > What happened to HiP04 support? I thought that would arrive
> > > in time for 3.17.
> > >
> > 
> > I just sent v14 in this week. I already updated gic & mcpm according
> > to comments. But I haven't gotten any comments & Ack yet. So I don't
> > know whether we could send the pull request of HiP04 in 3.17.
> 
> I don't see anything beyond v10 in my email, and that had a few
> outstanding comments but otherwise looked almost ready to me.
> Can you find out what happened?

I'd like Marc to review the newest version of the changes to the GIC and
Ack before I'll pull them in.  He was on vacation up until today.
You'll be able to pull in a tag on irqchip/gic and base off of that if
needed.

Conversely, if you were to move the HiP04 to a separate file, like I
asked, (using Mark's suggestion of function pointers, which you've
done), I could probably Ack it to go through arm-soc.  There are simply
too many changes to irq-gic.c this time around...

thx,

Jason.
