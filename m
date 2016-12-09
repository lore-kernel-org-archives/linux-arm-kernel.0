From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Dec 2016 09:11:03 +0100
Subject: [PATCH 2/2] arm: dts: sun8i: reuse the uart1 node of iNet D978
 rev2 board
In-Reply-To: <20161205184745.lfW8ji5w@smtp1m.mail.yandex.net>
References: <20161205184745.lfW8ji5w@smtp1m.mail.yandex.net>
Message-ID: <20161209081103.4h3irlbq6t4pz2ac@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 05:03:35PM +0800, Icenowy Zheng wrote:
> 
> 2016?12?5? 16:50? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Fri, Dec 02, 2016 at 11:19:13PM +0800, Icenowy Zheng wrote: 
> > > As a uart1 node is added into sun8i-reference-design-tablet.dtsi, simply 
> > > use it in iNet D978 rev2 device tree. 
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> >
> > I'd like to see more consolidation before that change is needed. If we 
> > find more boards using that, it will make sense, but for a single 
> > board it's not worth it. 
> 
> At least 2~3 Q8 A33 tablets in #linux-sunxi are found to have
> rtl8703as, which contains UART bluetooth. (including mine)

Still, I'm not fond of creating a default on such a low count sample
of (out-of-tree) DTs. Support and enable the bluetooth on more boards,
and then consolidate.

> In fact, what I want to do is to get the node ready-to-be-okay in Q8
> dts, so it can be enabled by either u-boot command or (theortically)
> Hans de Goede's q8-hardwaremgr, just like what is done at
> touchscreen node.

If your plan is to enable all the combinations possible accross the Q8
tablets and let the bootloader/user figure it all out, then it's not
going to happen, sorry.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161209/1271c094/attachment.sig>
