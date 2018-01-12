From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 12 Jan 2018 09:51:34 +0100
Subject: [linux-sunxi] [PATCH 1/7] pinctrl: sunxi: add support for pin
 controllers without bus gate
In-Reply-To: <3A97A26E-0774-4279-B7B9-8312225E2C72@aosc.io>
References: <20180106042326.46519-1-icenowy@aosc.io>
 <ef82983f-6f91-46c2-1f67-7d4efc10c905@arm.com>
 <3A97A26E-0774-4279-B7B9-8312225E2C72@aosc.io>
Message-ID: <20180112085134.dcsikciujsxuuwhx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;5002;0c
On Thu, Jan 11, 2018 at 09:21:06PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2018?1?11? GMT+08:00 ??7:48:40, Andre Przywara <andre.przywara@arm.com> ??:
> >Hi,
> >
> >another take to avoid this patch at all, I just remembered this from an
> >IRC discussion before:
> >
> >On 06/01/18 04:23, Icenowy Zheng wrote:
> >> The Allwinner H6 pin controllers (both the main one and the CPUs one)
> >> have no bus gate clocks.
> >
> >I don't think this is true. The pin controller *needs* an APB clock,
> >it's just not gate-able or not exposed or documented.
> >The "system bus tree" on page 90 in the manual shows that the "GPIO"
> >block is located on the APB1 bus.
> >So can't we just reference this apb clock directly? That would be much
> >cleaner, "more" correct and require less changes: "The best patch is no
> >patch":
> 
> I can accept this. (In fact I have considered this, but
> I don't dare to directly use bus clock in a device, as it's not
> exported before.
> 
> Maxime, Chen-Yu, can you agree the following code?

Yes, that works for me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/6f3306e5/attachment-0001.sig>
