From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Dec 2016 09:55:20 +0100
Subject: [linux-sunxi] Re: [PATCH v7 4/8] drm/sunxi: Add DT bindings
 documentation of Allwinner HDMI
In-Reply-To: <1971681480527210@web5g.yandex.ru>
References: <cover.1480414715.git.moinejf@free.fr> <4614815.L3DQhhBy6d@avalon>
 <20161130102757.9eec1f7f3377d0f4787e3829@free.fr>
 <3478036.d2UQM8n6lv@avalon>
 <20161130114415.2280151e2965280733a629e5@free.fr>
 <1971681480527210@web5g.yandex.ru>
Message-ID: <20161201085520.tk2kdi33rn6fyld2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 01:33:30AM +0800, Icenowy Zheng wrote:
> >> ?????????hdmi-out {
> >> ?????????????????compatible = "hdmi-connector";
> >> ?????????????????type = "a";
> >> ?????????????????/* I2C bus and GPIO references are made up for the example */
> >> ?????????????????ddc-i2c-bus = <&i2c4>;
> >> ?????????????????hpd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>
> >
> > the "hdmi-connector" is a big piece of software. It must handle a lot
> > of more and more exotic connectors.
> > So, I hope that you have written a "simple-hdmi-connector" which does
> > nothing but setting the connector type.
> > Where is it?
> 
> I suddenly thought about something...
> 
> If a DVI connector instead of a HDMI connector is soldered, how
> should such a device tree be written?

Use a dvi-connector instead :)

> How about solder a HDMI-to-VGA bridge on the board? (Maybe there
> should be "dumb-hdmi-dvi-bridge" and "dumb-hdmi-vga-bridge"
> drivers?)

It probably wouldn't be dumb, but yeah, it would definitely be a
bridge instead of the connector.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/1f559ca4/attachment.sig>
