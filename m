From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 15:47:04 +0200
Subject: [PATCH 05/12] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short
 write 2 param transfer
In-Reply-To: <CAMty3ZCD4ArjhPJYxv3ztWXdnby8YXQ73QqoVNoHFBc-DAxx_w@mail.gmail.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-6-jagan@amarulasolutions.com>
 <20180927171831.2nfybgn2xmc4vrgt@flea>
 <CAMty3ZCD4ArjhPJYxv3ztWXdnby8YXQ73QqoVNoHFBc-DAxx_w@mail.gmail.com>
Message-ID: <20180929134704.ylcg32xtk5m2pyoj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 11:06:50PM +0530, Jagan Teki wrote:
> >
> > >               ret = sun6i_dsi_dcs_write_short(dsi, msg);
> > > @@ -885,6 +886,8 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
> > >               }
> > >
> > >       default:
> > > +             dev_err(dsi->dev, "unsupported message type 0x%02x\n",
> > > +                     msg->type);
> >
> > And this isn't an error check.
> 
> But unsupported message type by sun6i_dsi should be an error
> eventually isn't it?

It's already an error condition. What you're adding, and unlike what
your commit log says, is not an error check...

> and we can easily figure out where the error trigger.

... but instead an error message.

That's definitely not the same thing, and I'm not sure we actually
need it. If a driver requests multiple transfers that are unsupported,
we'll end up spaming the kernel logs, especially when it can and
should be checked in the driver doing those transfers.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
