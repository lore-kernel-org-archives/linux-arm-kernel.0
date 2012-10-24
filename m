From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 22:21:39 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
In-Reply-To: <20121024201545.GA21046@lunn.ch>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121024201545.GA21046@lunn.ch>
Message-ID: <20121024222139.40fb2ad5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 24 Oct 2012 22:15:45 +0200, Andrew Lunn wrote:
> On Wed, Oct 24, 2012 at 09:18:01PM +0200, Thomas Petazzoni wrote:
> > Note: this patch is a *RFC*, it is not intended for merging, only to
> > get a discussion started. The code is horrible, makes terrible
> > assumptions and so on.
> > 
> > On many platforms, most of the pinmux initialization is done in the
> > bootloader, and therefore persists when we boot the Linux kernel. This
> > prevents us from making sure that the pinmux configuration in the
> > board device trees is correct.
> 
> You can get a lot of information from /debug. eg,
> # cat /debug/pinctrl/f1010000.pinctrl/pinconf-groups 

Yes, I was using that one...


> # cat /debug/pinctrl/f1010000.pinctrl/pinmux-pins 
> Pinmux settings per pin
> Format: pin (name): mux_owner gpio_owner hog?

... but not that one.

> If you compare the two, you can see that pin 6 has probably been set by
> uboot, but not by DT.

Indeed, by correlating the two files, you can get a good view of which
pins are configured even though no driver has claimed them. I don't
think it's as clear as having a non-functional device due to the pin
not being muxed at all, but if it is thought as being sufficient, then
fair enough.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
