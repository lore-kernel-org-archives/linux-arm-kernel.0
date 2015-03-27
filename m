From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Mar 2015 06:23:18 +0100
Subject: [PATCH 04/13] thermal: Fix not emulating critical temperatures
In-Reply-To: <CADGdYn5vaPu4+yhjs5c3QuCnz-LtL2Z2qRENjsizpO6D1gVOSg@mail.gmail.com>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
 <CADGdYn5vaPu4+yhjs5c3QuCnz-LtL2Z2qRENjsizpO6D1gVOSg@mail.gmail.com>
Message-ID: <20150327052318.GO9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Fri, Mar 27, 2015 at 08:35:50AM +0530, amit daniel kachhap wrote:
> Hi Sascha,
> 
> > -#ifdef CONFIG_THERMAL_EMULATION
> > -       if (!tz->emul_temperature)
> > -               goto skip_emul;
> > -
> > -       for (count = 0; count < tz->trips; count++) {
> > -               ret = tz->ops->get_trip_type(tz, count, &type);
> > -               if (!ret && type == THERMAL_TRIP_CRITICAL) {
> > -                       ret = tz->ops->get_trip_temp(tz, count, &crit_temp);
> > -                       break;
> > -               }
> > -       }
> > -
> > -       if (ret)
> > -               goto skip_emul;
> >
> > -       if (*temp < crit_temp)
> I guess this check is confusing. Actually instead of returning
> emulating temperature it is returning actual temperature. But the
> important thing to look here is that actual temperature is higher than
> critical temperature. So this check prevents the user from suppressing
> the critical temperature and hence prevents from burning up the chip.

Indeed the check is confusing, but now it makes perfectly sense. I'll
look at the patch again and maybe turn into a patch just adding a
comment to clarify this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
