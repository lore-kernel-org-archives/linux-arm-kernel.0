From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 09:58:23 +0200
Subject: [PATCH 0/3] Add ethernet0 alias for several A64 boards
In-Reply-To: <20170722022852.7868-1-icenowy@aosc.io>
References: <20170722022852.7868-1-icenowy@aosc.io>
Message-ID: <20170724075823.7ttjq4tnvoupo776@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 10:28:49AM +0800, Icenowy Zheng wrote:
> Allwinner A64 SoC has an EMAC which is used to provide Ethernet
> function on several boards.
> 
> The EMAC itself doesn't have a fixed MAC address, but the sunxi
> mainline U-Boot have the ability to generate one based on the eFUSE
> SID in the chip, and add the generated MAC address to the device
> tree when booting.
> 
> The MAC address setting step is based on the device tree's aliases,
> and device tree nodes prefixed "ethernet" will get the MAC address
> added. However, in several A64 boards' device tree, the alias is not
> set up, so that the U-Boot won't set the MAC address.
> 
> Add the ethernet0 aliases to these boards.
> 
> I hope this patchset can be queued in 4.13, otherwise 4.13 kernels
> won't get non-volatile MAC addresses, and will use random ones
> instead, which is annoying to many users.
> 
> Icenowy Zheng (3):
>   arm64: allwinner: a64: add ethernet0 alias for BPi M64 EMAC node
>   arm64: allwinner: a64: add ethernet0 alias for Pine64 EMAC node
>   arm64: allwinner: a64: add ethernet0 alias for SoPine EMAC node

Applied all three, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/54c525d7/attachment-0001.sig>
