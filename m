From: guenter.roeck@ericsson.com (Guenter Roeck)
Date: Thu, 11 Aug 2011 09:38:22 -0700
Subject: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
In-Reply-To: <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
Message-ID: <1313080702.2214.69.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-11 at 09:00 -0400, J, KEERTHY wrote:
> On Thu, Aug 11, 2011 at 4:06 PM, Felipe Balbi <balbi@ti.com> wrote:

[ ... ]

> >> >> +     temp = omap_temp_sensor_readl(temp_sensor,
> >> >> +                     temp_sensor->registers->bgap_counter);
> >> >> +     temp = (temp & temp_sensor->registers->counter_mask) >>
> >> >> +                     __ffs(temp_sensor->registers->counter_mask);
> >> >
> >> >        temp &= ??
> >> >
> >> >> +     temp = temp * 1000 / (temp_sensor->clk_rate);
> >> >
> >> >        temp *= ??
> >>
> >> Need to multiply the temp with 1000 before dividing.
> >> temp *= evaluates the RHS first and then multiplies LHS.
> >
> > temp *= 1000;
> > temp /= clk_rate;
> >
> 
> Different coding style. I preferred to do it in a single line.
> 
Me too.

Guenter
