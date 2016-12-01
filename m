From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 01 Dec 2016 12:41:20 +0200
Subject: [linux-sunxi] Re: [PATCH v7 4/8] drm/sunxi: Add DT bindings
 documentation of Allwinner HDMI
In-Reply-To: <20161201085520.tk2kdi33rn6fyld2@lukather>
References: <cover.1480414715.git.moinejf@free.fr>
 <1971681480527210@web5g.yandex.ru> <20161201085520.tk2kdi33rn6fyld2@lukather>
Message-ID: <5021537.YAZCMeDTSh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 Dec 2016 09:55:20 Maxime Ripard wrote:
> On Thu, Dec 01, 2016 at 01:33:30AM +0800, Icenowy Zheng wrote:
> >>>          hdmi-out {
> >>>                  compatible = "hdmi-connector";
> >>>                  type = "a";
> >>>                  /* I2C bus and GPIO references are made up for the
> >>> example */ ddc-i2c-bus = <&i2c4>;
> >>>                  hpd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>
> >> 
> >> the "hdmi-connector" is a big piece of software. It must handle a lot
> >> of more and more exotic connectors.
> >> So, I hope that you have written a "simple-hdmi-connector" which does
> >> nothing but setting the connector type.
> >> Where is it?
> > 
> > I suddenly thought about something...
> > 
> > If a DVI connector instead of a HDMI connector is soldered, how
> > should such a device tree be written?
> 
> Use a dvi-connector instead :)

The HDMI encoder DT node doesn't (and certainly shouldn't) report what type of 
connector is mounted on the board. Having a connector node in DT makes the 
connector type available to the system, allowing the DRM driver to expose the 
right connector type to userspace (it would be confusing for the user to 
report DRM_MODE_CONNECTOR_HDMIA for a DVI connector).

> > How about solder a HDMI-to-VGA bridge on the board? (Maybe there
> > should be "dumb-hdmi-dvi-bridge" and "dumb-hdmi-vga-bridge"
> > drivers?)
> 
> It probably wouldn't be dumb, but yeah, it would definitely be a
> bridge instead of the connector.

-- 
Regards,

Laurent Pinchart
