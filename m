From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Feb 2017 16:56:05 +0100
Subject: [linux-sunxi] Re: [PATCH v3 04/10] clk: sunxi-ng: add support
 for Allwinner H5 SoC
In-Reply-To: <20170207000838.8UJeKISe@smtp2p.mail.yandex.net>
References: <20170207000838.8UJeKISe@smtp2p.mail.yandex.net>
Message-ID: <20170207155605.f2k44gr56ywehz3t@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:02:04PM +0800, Icenowy Zheng wrote:
> > >? static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] = { 
> > >? [RST_USB_PHY0] =? { 0x0cc, BIT(0) }, 
> > >? [RST_USB_PHY1] =? { 0x0cc, BIT(1) }, 
> > > @@ -791,6 +910,7 @@ static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] = { 
> > >? [RST_BUS_UART2] =? { 0x2d8, BIT(18) }, 
> > >? [RST_BUS_UART3] =? { 0x2d8, BIT(19) }, 
> > >? [RST_BUS_SCR0] =? { 0x2d8, BIT(20) }, 
> > > + [RST_BUS_SCR1] =? { 0x2d8, BIT(21) }, 
> >
> > That reset line is not valid on the H3. 
> 
> So I should split a H3 reset array and a H5 one?

Ideally, yes.

> (I modelled after ccu-sun5i.c, which shares one reset array)

They all share the same reset lines.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/b9b403ea/attachment.sig>
