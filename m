From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 22:40:41 +0100
Subject: [linux-sunxi] Re: BUG - Bananapi USB not working on Mainline
In-Reply-To: <4c69f067-f61d-4cf2-b5e6-75e7a22bedf7@googlegroups.com>
References: <CAOP4N=_Ux0FPSRep7AfBVovd59LeDTbBjH=LBdfWDb6Mc3e=Fg@mail.gmail.com>
 <ec8d762c-3e2b-4438-a43e-ae2740f8a5f3@googlegroups.com>
 <ed63cc0b-fb90-4947-ab4c-b89655538a1a@googlegroups.com>
 <CAOP4N=98cjUYVAvEngdOXXdXeive7HB_ChC4B+uAASG5tKP1dg@mail.gmail.com>
 <4c69f067-f61d-4cf2-b5e6-75e7a22bedf7@googlegroups.com>
Message-ID: <20151227214041.GO30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 22, 2015 at 06:42:07AM -0800, m.silentcreek at gmail.com wrote:
> Am Sonntag, 20. Dezember 2015 08:38:52 UTC+1 schrieb David Tulloh:
> > On 20 December 2015 at 08:39,  <m.sile...@gmail.com> wrote:
> > 
> > I found the solution! The problem is CONFIG_AXP20X_POWER which was
> > introduced in 4.4-rc1 but defaults to no and not set in
> > sunxi_defconfig. Adding CONFIG_AXP20X_POWER=y to sunxi_defconfig
> > solves that and get's my USB devices working again on linux
> > 4.4-rc5. I actually brought that up on IRC once, but at that time
> > nobody seemed to know so I forgot it again.
> > 
> > Thanks Timo,
> > 
> > I can confirm that adding CONFIG_AXP20X_POWER=y to sunxi_defconfig
> > works for me as well.
> 
> Is this considered an issue worthwhile to be addressed before the
> release of 4.4?
> 
> The way I see it is that USB support is broken on A10/20 in mainline
> for anybody who builds on sunxi_defconfig or multi_v7_defconfig at
> the moment.

I don't consider it a "release blocker". The defconfig is just what it
says: a default configuration. It's not a one-size-fits-all
configuration.

> I think we should either have CONFIG_PHY_SUN4I_USB select
> CONFIG_AXP20X_POWER automatically (my preferred solution)

It actually depends on the board, so no.

> or at least add it to sunxi_defconfig and multi_v7_defconfig.

Feel free to send a patch for it to arm at kernel.org in addition to the
usual recipients (Chen-Yu, LAKML and myself), and make it clear that
you want them to apply it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/16c6bdc7/attachment.sig>
