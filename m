From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 2 Oct 2009 16:11:06 +0200
Subject: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
In-Reply-To: <4e090d470910020117w620fda4cta7b26b912d01bc24@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com>
	<20091001083831.GD27039@pengutronix.de>
	<4e090d470910010211k4ce78763i1a5163ec6ea57fe8@mail.gmail.com>
	<20091001095239.GE27039@pengutronix.de>
	<4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com>
	<20091001163753.GA20103@pengutronix.de>
	<4e090d470910011757g261c693ehdca40ce43ebee2ec@mail.gmail.com>
	<20091002072643.GH27039@pengutronix.de>
	<4e090d470910020117w620fda4cta7b26b912d01bc24@mail.gmail.com>
Message-ID: <20091002141106.GG3179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2009 at 04:17:09PM +0800, Richard Zhao wrote:
> On Fri, Oct 2, 2009 at 3:26 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Fri, Oct 02, 2009 at 08:57:04AM +0800, Richard Zhao wrote:
> >> On Fri, Oct 2, 2009 at 12:37 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> >> >> > Ah, so 'make the driver work on i.MX51' is a good statement which should
> >> >> > be part of the commit message.
> >> >> Well, maybe I can mention it.
> >> >> But I think the good point is to present what you modified, not the side effect.
> >> >
> >> > It is not the side effect but the intention :) As no code is changed without a
> >> > need, the reason really should be in the patch description.
> >> No, it's not intention. I'm just trying to make the controller work in
> >> a right way. Without this patch, maybe some other fast cpus have
> >> problem too. I just tested mx31 and mx51. I will add "Without this
> >> patch, i2c on some fast SoCs (for example imx51) will not work". Is it
> >> ok for you?
> >
> > Please remember that we do not have i.MX51 support in mainline, so this
> > is irrelevant atm.
> So I don't need to meantion mx51? "Without this patch, i2c on some
> fast SoCs will not work" is all right?

Sounds good to me!

> > At the moment we have a driver which is not multi master capable.
> > Looking at the datasheet the change you do seems not enough to change
> > this. So we should take a patch which changes something from which you
> > think it might be needed? And you don't even have the details at hand?
> >
> > No.
> Ok, It seems I have no reason to keep the busy wait before START.
> Wolfram, do you agree to remove the busy wait?

If somebody really needs multi-master and is able to test it, then it can be
reimplemented (but as said, this needs a lot more changes). Have to have a
closer look though, if it may detect a stalled bus.

> I saw you submmited the original driver.

I helped in getting it accepted, but the commit is mainly from Darius.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091002/81cecc6c/attachment.sig>
