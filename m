From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Sep 2015 22:56:03 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <55ED3739.609@redhat.com>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
Message-ID: <20150907205603.GX31584@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 09:05:29AM +0200, Hans de Goede wrote:
> >>+&reg_ldo3 {
> >>+	/*
> >>+	 * We need to always power the camera sensor, otherwhise all access
> >>+	 * to i2c1 is blocked.
> >>+	 */
> >>+	regulator-always-on;
> >>+	regulator-min-microvolt = <2800000>;
> >>+	regulator-max-microvolt = <2800000>;
> >>+	regulator-name = "vdd-csi";
> >>+};
> >
> >What is connected on i2c1 ? Just the camera sensor? or it has some
> >other devices there?
> 
> The bma250 accelerometer sits there, and the kernel already has a driver
> for it. That driver needs to have devicetree binding support added, and
> then we should be able to use the accelerometer.

Ok, so if this regulator is disable, you can't access the other
devices as well, right? Do you know why? Is it the regulator providing
the pull-up voltage?

I'd still like Wolfram's insight on this one. Wolfram, do you have a
suggestion and / or a comment on how to deal with such a case?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150907/47f3fe4a/attachment.sig>
