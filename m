From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Tue, 5 Jul 2016 11:25:10 +0200
Subject: [linux-sunxi] [PATCH 2/4] power: add axp20x-battery driver
In-Reply-To: <4101467707611@web7h.yandex.ru>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
 <20160701092926.32005-2-icenowy@aosc.xyz>
 <577B44FD.6040404@mailbox.org> <4101467707611@web7h.yandex.ru>
Message-ID: <20160705092510.GL7643@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 04:33:31PM +0800, Icenowy Zheng wrote:
> 
> 
> 05.07.2016, 13:26, "Michael Haas" <michael.haas@mailbox.org>:
> > Hi,
> >
> > nice work! Is this in any way related to Bruno Pr?monts driver for the
> > axp20x?
> >
> > I've got a reworked version of that lying around, but it's not quite
> > ready for submission. Do you know what pieces are missing in your driver
> > for axp20x support - as opposed to axp22x, which is already working?
> 
> Therotically, it can run on axp20x. However, I have currently no
> test device. (Still waiting for my C.H.I.P.)  So I can only promise
> it to run on axp22x.

Still, it looks like you just took Bruno's driver, stripped out the
axp20x parts and added the one to deal with axp22x.

This makes the driver look weird, by being called axp20x, without
actually supporting those PMICs, but having some axp22x variables
right in the middle. And that's awfully inconsistent.

I'd rather have you add the AXP20x driver directly, and then add the
needed stuff for the AXP22x.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/5afd99f8/attachment.sig>
