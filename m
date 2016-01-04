From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 17:12:57 +0000
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <CACRpkdZsQc_Jug1dy-qist4Dv7HTDDx-fBjXTxj+s7W0sgJSuw@mail.gmail.com>
References: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
 <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
 <20151230172212.GZ16023@sirena.org.uk>
 <CAGS+omA9AarzE2sp1Ry3RuOt8EOa-sL=DL1iDA2OeVVdjn=xgg@mail.gmail.com>
 <20151231220712.GD16023@sirena.org.uk>
 <CAGS+omDesPTYHhVLv_EtQsYxa6MNuSi06MwcXz6RcY=uAcEtnQ@mail.gmail.com>
 <DBFC9B9B-5E81-44FD-9E26-8B50545004C1@gmail.com>
 <CACRpkdZsQc_Jug1dy-qist4Dv7HTDDx-fBjXTxj+s7W0sgJSuw@mail.gmail.com>
Message-ID: <20160104171257.GO16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 06:29:15PM +0100, Linus Walleij wrote:
> On Fri, Jan 1, 2016 at 3:27 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:

> > I think what Mark means is, that we define some pinctrl_initcall which
> > is a macro to subsys_initcall (or arch_initcall or similar). We apply this
> > to all pinctrl drivers including the one from Mediatek. This way at least
> > we have a common method and changing the behaviour in the future is
> > easier to handle.

> That would be pinctrl_soc_initcall() in that case. Just pinctrl_initcall()
> would assume it's for all drivers and there is a bunch of them that are just
> fine with simple device_initcall()s.

OTOH it might be easier to just have an initcall (or fiddle with the
link order) for everything to avoid having to think about which drivers
things apply to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/ac8ca8f8/attachment.sig>
