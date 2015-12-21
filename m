From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Dec 2015 17:11:32 +0100
Subject: [linux-sunxi] Re: [PATCH 4/5] ARM: dts: sun5i: Add dts file for
 the Empire Electronix D709 tablet
In-Reply-To: <5677D87A.90805@redhat.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
 <1450611782-9494-4-git-send-email-hdegoede@redhat.com>
 <CAGb2v65daCCOWf7EXDkNWnxv1idXHXesOp6Et_0h-o+9drdeMA@mail.gmail.com>
 <5677D87A.90805@redhat.com>
Message-ID: <20151221161132.GA30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,x

On Mon, Dec 21, 2015 at 11:46:18AM +0100, Hans de Goede wrote:
> >On the side, any thoughts on how to handle the differences between various "Q8"
> >tablets, like different I2C-based sensors and WiFi chips?
> 
> For i2c based sensors the plan is to use devicetree overlays + an in kernel
> overlay manager which probes the i2c bus (checking known touchscreen / accelerometer
> addresses) and then picks the right touchscreen + accelerometer overlays.
> 
> Wifi is somewhat more tricky I must admit, esp. since there seem to be q8 a23 based
> tablet variants with usb wifi and others with sdio wifi. Since both busses are
> discoverable I'm tempted to just enable both in devicetree, and let the kernel probe
> and see what is actually there. This assume that the way the wifichip is powered
> is the same on all boards, or at least that it is safe to enable the necessary
> regulators on all boards ...
> 
> >I'm asking because with Maxime's couple-regulator we should be able to get the
> >RTL8723BS on the Q8 A23/33 v1.5 working.
> 
> So this means enabled the sdio controller (should be safe on all boards?) and
> enabling 2 regulators to power the wifi-chip. I think it will be safe to do this
> even on boards where those regulators are not used, what do you think ?

Wouldn't that introduce some useless power drain on those boards?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/2ca1c560/attachment.sig>
