From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 09:06:11 +0100
Subject: [PATCH 1/4] phy: sun4i-usb: support PHY0 on H3 in MUSB mode
In-Reply-To: <20170116191449.50397-2-icenowy@aosc.xyz>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
 <20170116191449.50397-2-icenowy@aosc.xyz>
Message-ID: <20170117080611.tn7s7ddj2csqr27m@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:14:46AM +0800, Icenowy Zheng wrote:
> The PHY0 on H3 can be wired either to MUSB controller or OHCI/EHCI
> controller.
> 
> The original driver wired it to OHCI/EHCI controller; however, as the
> code to use PHY0 as OHCI/EHCI is missing, it makes the PHY fully
> unusable.
> 
> Rename the register (according to its function and the name in BSP
> driver), and remove the code which wires the PHY0 to OHCI/EHCI, as MUSB
> can support both peripheral and host mode (although the host mode of
> MUSB is buggy).

Can you elaborate on that? What's wrong with it?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/c5217ff0/attachment.sig>
