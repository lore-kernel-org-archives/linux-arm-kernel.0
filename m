From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Jul 2014 22:59:38 +0200
Subject: [GIT PULL v2.1] Mediatek basic support for v3.17
In-Reply-To: <20140722181857.GK21766@n2100.arm.linux.org.uk>
References: <CABuKBeLc=Bbpqrksdjoc_0Sx_rVpZLuY1aUY1WtK5Vp20Jiv8g@mail.gmail.com>
 <20140722181857.GK21766@n2100.arm.linux.org.uk>
Message-ID: <201407232259.39339.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014, Russell King - ARM Linux wrote:
> Your To: header contains many tens of people.  Which person out of
> all those do you expect to pull your changes?
> 
> Email has a way to identify whom you are talking _to_ and whom you wish
> to _copy_ for information purposes.
> 
> These are the "To:" and "Cc:" fields on email.  Those on the "To:" list
> are those who you are directly addressing your message.  Those on the
> Cc: list are "Carbon Copy" recipients, in other words, ones you are
> notifying for information purposes.

Absolutely. In addition, I'd recommend always addressing the maintainer
by name, with a friendly greeting, to ensure they really know they
are meant.

I would also add that you should be careful with the number of people
on Cc in any email. If the Cc list exceeds 1024 characters, the kernel.org
mailing lists will reject your mail. It normally isn't necessary to
have all those people on Cc.

As a special case for arm-soc, please send the patches "To: arm at kernel.org"
so it ends up in the right folders for Olof and me.

> > ----------------------------------------------------------------
> > The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> > 
> >   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/mbgg/linux-mediatek.git tags/v3.17-next-mediatek-support
> > 
> > for you to fetch changes up to afaedea451149ab8f08c37ce688c8021ed347811:
> > 
> >   arm: mediatek: add dts for Aquaris5 mobile phone (2014-07-22 17:52:38 +0200)
> > 
> > ----------------------------------------------------------------
> > This patch set adds basic support for the Mediatek Cortex-A7 SoCs.
> > 
> > Support is quite basic, as the only component working up to now are the
> > timers.
> > 
> > Signed-off-by: Matthias Brugger matthias.bgg at gmail.com
> > 
> > ----------------------------------------------------------------
> > Matthias Brugger (3):
> >       arm: add basic support for Mediatek MT6589 boards
> >       dt-bindings: add documentation for Mediatek SoC
> >       arm: mediatek: add dts for Aquaris5 mobile phone

Patches look good, I've pulled them into the next/soc tree. It would be
good for the future to sign your tags with a gpg key that is signed by
other kernel developers you know.

Two other patches I'd like to see are:

- adding the dts file to ls arch/arm/boot/dts/Makefile
- adding your platform and all drivers you need to multi_v7_defconfig
  so they are included in regular build tests.

Thanks,

	Arnd
