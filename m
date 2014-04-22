From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Apr 2014 17:18:40 +0200
Subject: [PATCH 2/7] gpiolib: Support purely name based gpiod lookup in
 device trees
In-Reply-To: <CACRpkdZ+3dnhoj1TS4KSVUP8iFHsjjwop-FG2Nf07YtH6aSO_Q@mail.gmail.com>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-3-git-send-email-wens@csie.org>
 <CACRpkdZ+3dnhoj1TS4KSVUP8iFHsjjwop-FG2Nf07YtH6aSO_Q@mail.gmail.com>
Message-ID: <20140422151840.GH24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Apr 22, 2014 at 05:00:17PM +0200, Linus Walleij wrote:
> On Tue, Apr 15, 2014 at 8:41 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> 
> > This patch enables gpio-names based gpiod lookup in device tree usage,
> > which ignores the index passed to gpiod_get_index. If this fails, fall
> > back to the original function-index ("con_id"-gpios) based lookup scheme,
> > for backward compatibility and any drivers needing more than one GPIO
> > for any function.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> This looks a bit scary and I cannot claim to realize the entire semantic
> effect of this patch, but if it's the way to go then OK.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Shall I just apply this to the GPIO tree or are you carrying it along with
> the other stuff?

This patch has a dependency on the first patch of this serie, since it
uses a binding that was documented there.

Maybe you'll want to wait for the ACK from the DT maintainers to merge
this one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140422/3fbc1df2/attachment.sig>
