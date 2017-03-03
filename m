From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Fri, 3 Mar 2017 15:51:01 +0100
Subject: [linux-sunxi] Re: [PATCH 2/3] clk: sunxi-ng: add support for
 PRCM CCUs
In-Reply-To: <2899221488467633@web38j.yandex.ru>
References: <20170301152236.MUXmRgOe@smtp1m.mail.yandex.net>
 <20170302140931.tq3vpncln6giyjpr@lukather>
 <2899221488467633@web38j.yandex.ru>
Message-ID: <20170303145101.ynv6vmmy4fyrgezw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 11:13:53PM +0800, Icenowy Zheng wrote:
> 
> 
> 02.03.2017, 22:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Wed, Mar 01, 2017 at 08:22:13PM +0800, Icenowy Zheng wrote:
> >> ?> I'm a bit worried by that to be honest. You claim to support the A31,
> >> ?> yet jugdging by the current state of that code you never actually
> >> ?> tested it on that SoC.
> >> ?>
> >> ?> What makes you say that the PRCM clocks are the same for the H3 and
> >> ?> A64? We have to be sure, otherwise we might not be able to get the DT
> >> ?> binding right from the very beginning, and we might not be able to fix
> >> ?> it later.
> >>
> >> ?In fact, if we worry about this, we shouldn't make r-ccu, as
> >> ?dedicated clocks are more easy to fix.
> >>
> >> ?For newer SoCs' PRCM, we never have enough documents, and Allwinner
> >> ?have said that they cannot provide it. (I asked them for this.)
> >>
> >> ?The best solution is to implement mature enough dedicated clocks
> >> ?before we convert to ccu.
> >
> > What do you mean by dedicated clocks?
> 
> The legacy form of clocks.

Which itself creates another form of issues. What happens if we get
something wrong on those clocks (as it is likely to happen)?

We potentially can't fix it at all, that's what happens.

And that's leaving aside the DT and clocks maintainers regular
complaints that we should get away from those.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170303/a049eba7/attachment.sig>
