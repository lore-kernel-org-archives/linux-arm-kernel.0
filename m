From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Sep 2015 10:48:36 -0700
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
Message-ID: <20150918174836.GG8020@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [150918 10:39]:
> Hello Tony,
> 
> [snip]
> 
> >
> > +       vmmcsdio_fixed: fixedregulator-mmcsdio {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "vmmcsdio_fixed";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               gpio = <&gpio5 12 GPIO_ACTIVE_HIGH>;    /* gpio140 WLAN_EN */
> 
> I know that other OMAP boards use a fake fixed regulator to toggle the
> WiFi enable pin but now the MMC subsystem has proper support for power
> sequence providers so that should be used instead. For simple uses
> like this, Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> should be enough.

Hmm OK great, I'll take a look. Looks like that might also provide a
nice solution for handling the 32k clock from palmas to the wl12xx.

In the wl12xx case it's a real regulator on wl12xx though, not a fake.
It gets the power directly from VBAT and generates it's own clocks..
Of course nobody knows what the chip is actually doing with the GPIO
pin, it's probably just a hint to some wl12xx internal state machine.

Regards,

Tony
