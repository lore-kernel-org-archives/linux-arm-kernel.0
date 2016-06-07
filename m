From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jun 2016 23:24:19 +0200
Subject: [PATCH 1/3] ARM: dts: sun4i: The blue led on the Mele A1000 is a
 power led
In-Reply-To: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
References: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160607212419.GE14179@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2016 at 02:23:11PM +0200, Hans de Goede wrote:
> The blue led on the Mele A1000 is wired to light up as soon as the board
> has powered (it will be on while the gpio is still in input / floating
> mode), also its location on the top-set box clearly signals "power led".
> 
> Until now we've been treating this as a generic usr function led, which
> means that when you plug power into the top-set box, the power-led lights
> and then turns off as soon as the kernel loads, which looks wrong.

I'm not sure I understand the relationship between usr vs pwr led and
the fact that it's disabled.

> This renames the led from a1000:blue:usr to a1000:blue:pwr and marks
> it as default on, fixing this.

however, the default on might. Is it just a confusing commit log, or
am I overlooking something?

thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/a71af183/attachment-0001.sig>
