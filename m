From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Dec 2015 17:22:12 +0000
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
References: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
 <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
Message-ID: <20151230172212.GZ16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 04:11:47PM +0100, Linus Walleij wrote:
> On Tue, Dec 22, 2015 at 2:46 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> > Move pinctrl initialization earlier in boot so that real devices can find
> > their pctldev without probe deferring.
> (...)
> > -module_init(mtk_pinctrl_init);
> > +arch_initcall(mtk_pinctrl_init);

> So I see why you're doing this (because of wanting to avoid nasty boot
> probe deferrals, right?) and I'm going to apply it, because the work
> with probe ordering is still in the works, but I'd like some general
> ARM people to come in with opinions.

I really don't think we should be applying this sort of stuff unless
things are actively broken right now.  It's a bit of a rabbit hole we
could spend a long time going down tweaking things for different
systems in the same way that tweaking the link order can be and it masks
the underlying issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151230/cffcf7fd/attachment-0001.sig>
