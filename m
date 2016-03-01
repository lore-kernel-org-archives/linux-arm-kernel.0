From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Feb 2016 20:43:28 -0800
Subject: [PATCH 1/2] pinctrl: sunxi: Remove non existing irq's
In-Reply-To: <bd43820c6708d57ff2997dccd588faa28da11990.1456698862.git.henry@nitronetworks.nl>
References: <cover.1456698862.git.henry@nitronetworks.nl>
 <bd43820c6708d57ff2997dccd588faa28da11990.1456698862.git.henry@nitronetworks.nl>
Message-ID: <20160301044328.GE8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 12:13:26AM +0100, Henry Paulissen wrote:
> While I was testing irq's on the cubietruck I found a couple of
> not working irq pins. Further diving into the problem it opened
> up a mess called "manual".
> 
> This so called manual (A20 user manual v1.3 dated 2014-10-10) says:
> 
> Pin overview:
>     Page 233:       EINT12 is on pin PC19 mux6.
>     Page 236:       EINT12 is on pin PH12 mux6.
> 
> Now, it is a bit strange to have the same IRQ on 2 different pins,
> but I guess this could still be possible hardware wise. But then:
> 
> Pin registers:
>     Page 253:       EINT12 is *not* on pin PC19.
>     Page 281:       EINT12 is on pin PH12.
> 
> The manual is so contradicting that further tests had to be made
> to see which of the 2 statements where correct.
> 
> This patch is based on actual outcome of these tests and not what
> the manual says.
> 
> Test procedure used:
> 
> Connect a 1 pulse per second (GPS) line to the pin.
> 
> echo pin### > /sys/class/gpio/export
> echo in > /sys/class/gpio/gpio###/direction
> echo rising > /sys/class/gpio/gpio###/edge
> 
> Check /proc/interrupts if a irq was attached and if irq's where
> received.
> 
> Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/0e3b8cc3/attachment-0001.sig>
