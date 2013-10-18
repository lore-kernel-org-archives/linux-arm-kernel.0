From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Oct 2013 09:06:15 -0700
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <52615AD4.7040306@ti.com>
References: <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
 <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
 <20131011154352.GO29913@atomide.com>
 <CACRpkdZhbadd5d4P+2B0_DktqK4CHzZPVJC8kPHZYUnp8TaxsA@mail.gmail.com>
 <20131011160146.GR29913@atomide.com> <5260E606.2030903@ti.com>
 <20131018153541.GJ15154@atomide.com> <52615AD4.7040306@ti.com>
Message-ID: <20131018160615.GM15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Balaji T K <balajitk@ti.com> [131018 08:59]:
> On Friday 18 October 2013 09:05 PM, Tony Lindgren wrote:
> >* Balaji T K <balajitk@ti.com> [131018 00:41]:
> >>
> >>Any conclusion on using regmap for omap control module non-mux registers ?
> >
> >I don't think anybody has even started looking into a SCM driver
> >yet considering there are tons of other issues to sort out.
> >
> >If you're thinking about implementing the MMC PBIAS driver, I would
> >just implement it as a standalone driver. It seems that the PBIAS
> >interface to the MMC driver can be just regulator framework.
> >
> Hi Tony,
> 
> I am testing pbias regulator, Just thinking whether it should be
> using regmap api or direct readl/writel

OK either or should work. It seems that can easily be changed
later on though.
 
> >Then when we have the SCM driver available, this driver can be
> >updated to coordinate things with the core SCM driver.
> 
> Do you see regmap getting used for the SCM driver ?

Yes eventually :)

Tony
