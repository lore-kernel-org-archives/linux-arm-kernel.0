From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 14 May 2014 11:41:42 -0700
Subject: [linux-sunxi] [PATCH v4 2/2] input: sun4i-ts: Add support for
 temperature sensor
In-Reply-To: <CAGb2v66EiYy3XbLqBXmOhOfHF=2DC_tOyQpdM8Q05iR6+X66zg@mail.gmail.com>
References: <1399795586-18919-1-git-send-email-hdegoede@redhat.com>
 <1399795586-18919-3-git-send-email-hdegoede@redhat.com>
 <CAGb2v66EiYy3XbLqBXmOhOfHF=2DC_tOyQpdM8Q05iR6+X66zg@mail.gmail.com>
Message-ID: <20140514184142.GG30089@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:44:51PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, May 11, 2014 at 4:06 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > @@ -232,14 +284,39 @@ static int sun4i_ts_probe(struct platform_device *pdev)
> >         writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
> >                ts->base + TP_CTRL1);
> >
> > -       ret = input_register_device(ts->input);
> > -       if (ret)
> > -               return ret;
> > +       hwmon = devm_hwmon_device_register_with_groups(ts->dev, "sun4i_ts",
> > +                                                      ts, sun4i_ts_groups);
> 
> This fails to compile when HWMON is not selected:
> 
> drivers/built-in.o: In function `sun4i_ts_probe':
> /home/wens/cubieboard/linux/drivers/input/touchscreen/sun4i-ts.c:287:
> undefined reference to `devm_hwmon_device_register_with_groups'
> 
> Best do a wrapper around the hwmon related code.
> drivers/input/touchscreen/ads7846.c has something similar, albeit for voltage.

I added dependency on HWMON and applied, thank you.

-- 
Dmitry
