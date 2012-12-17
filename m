From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Dec 2012 12:50:16 +0100
Subject: devicetree support for efikasb
In-Reply-To: <87licwdikj.fsf@lebrac.rtp-net.org>
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org>
Message-ID: <20121217115016.GN26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 12:27:56PM +0100, Arnaud Patard wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > Hi all,
> 
> Hi,
> 
> >
> > I recently put some work into my Efika MX smartbook. Here are patches
> > to make it work with a current kernel. It turned out that most of the
> > stuff is quite straight forward. Unfortunately there is a lot missing
> > in the USB area. Without USB support the Smartbook is pretty much
> > useless, so most of the patches are for adding USB support.
> >
> > What currently works is:
> >
> > - USB
> 
> Is it working or not ? Or you meant that it's working only if you merge
> the usbmisc-related for imx5* patches ?

It's working with the patches in the git branch. It requires usbmisc
patches and also ULPI support for the chipidea driver. I only bashed
the chipidea driver until it worked. The last time I looked at the
chipidea driver patches on the mailing list they were so much in flux
that it didn't make sense to me to post even more patches. I hope
this settles soon.

> 
> > - Display
> 
> Given that you wrote something for the mlt017, do you happen to have a
> sii9022 driver too ? :)

Only a very old one which won't work with the current code.

> 
> > - Battery
> 
> I've not noticed something for the ac power supply in the dts. Did I miss something?

I only added the following for the battery which is enough to detect it:

	battery: battery at 0b {
		compatible = "sbs,sbs-battery";
		reg = <0x0b>;
		sbs,battery-detect-gpios = <&gpio3 6 1>;
	};

I haven't done anything with the ac power supply yet. I suppose it's
detectable via a gpio, right?

> 
> > - keyboard/touchpad
> 
> Did you try using the white led for 'caps lock' ?

No, I only registered it as LED, I haven't tried to wire it up the caps
lock functionality. For me capslock is the most useless feature on a
keyboard, I usually reconfigure this to a addition modifier key anyway
;)

> 
> > - Sound (used to work, currently broken)
> > - Wifi
> 
> How did you enable it ? Did you configure the gpios to always enable it ?

I configured the corresponding gpio as input, so it seems to get
overwritten by the wifi switch. I don't know the schematics, but I'm
able to turn Wifi off and on with the switch.


> 
> > - LEDs
> 
> You're not mentionning pata. Is it working or not ?

Ah, missed that. PATA is working aswell. Only PIO though.

> 
> >
> > I'm not posting the patches here since I do not consider them ready, but
> > for everyone interested you can pull the following git tree. I have no
> > idea if the patches work together with the preinstalled U-Boot, I use
> > barebox on the Smartbook.
> 
> I've (very quickly) tested it yesterday and it didn't even boot. I've
> yet to look at the serial port output to check if it's a problem on my
> side or a bug in the kernel.

Do you mean barebox doesn't boot or the kernel doesn't boot?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
