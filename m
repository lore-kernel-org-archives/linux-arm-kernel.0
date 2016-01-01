From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Jan 2016 18:29:15 +0100
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <DBFC9B9B-5E81-44FD-9E26-8B50545004C1@gmail.com>
References: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
 <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
 <20151230172212.GZ16023@sirena.org.uk>
 <CAGS+omA9AarzE2sp1Ry3RuOt8EOa-sL=DL1iDA2OeVVdjn=xgg@mail.gmail.com>
 <20151231220712.GD16023@sirena.org.uk>
 <CAGS+omDesPTYHhVLv_EtQsYxa6MNuSi06MwcXz6RcY=uAcEtnQ@mail.gmail.com>
 <DBFC9B9B-5E81-44FD-9E26-8B50545004C1@gmail.com>
Message-ID: <CACRpkdZsQc_Jug1dy-qist4Dv7HTDDx-fBjXTxj+s7W0sgJSuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 1, 2016 at 3:27 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On January 1, 2016 3:56:01 AM EET, Daniel Kurtz <djkurtz@chromium.org> wrote:

>>> It's fairly clear that there's at least a case for simplifying the
>>> existing practice here, for example by moving everything into a
>>single
>>> (perhaps aliased) initcall rather than by randomly picking a level
>>per
>>> system or by actually fiddling with the link ordering if the case is
>>> sufficiently clear that pinctrl in general ought to load earlier than
>>it
>>> does.
>>
>>Nothing above sounds like a reason not to merge this patch, however.
>>Why should we block useful patches that use existing tools to fix real
>>architecture-specific issues until new infrastructure is merged that
>>solves general problems?
>
> I think what Mark means is, that we define some pinctrl_initcall which
> is a macro to subsys_initcall (or arch_initcall or similar). We apply this
> to all pinctrl drivers including the one from Mediatek. This way at least
> we have a common method and changing the behaviour in the future is
> easier to handle.

That would be pinctrl_soc_initcall() in that case. Just pinctrl_initcall()
would assume it's for all drivers and there is a bunch of them that are just
fine with simple device_initcall()s.

Yours,
Linus Walleij
