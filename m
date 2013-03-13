From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 14:55:48 +0000
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <51409276.8050601@gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet> <51408A71.9090501@gmail.com>
 <1363185757.3100.66.camel@hornet> <51409276.8050601@gmail.com>
Message-ID: <1363186548.3100.75.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 14:51 +0000, Rob Herring wrote:
> On 03/13/2013 09:42 AM, Pawel Moll wrote:
> > On Wed, 2013-03-13 at 14:17 +0000, Rob Herring wrote:
> >> How about:
> >>
> >> 1 irq - TIMINT1
> >> 2 irqs w/ same source # - TIMINTC
> >> 2 irqs w/ different source # - TIMINT1 and TIMINT2
> >>
> >> I'm not completely sure if Linux and the irq domain code handles the
> >> same interrupt source repeated. It should because that is basically a
> >> shared irq line.
> >>
> >> If we ever see only TIMINT2 connected we can add a property for that,
> >> but I think that case is unlikely.
> > 
> > I was rather thinking about using the "interrupt-names" property and
> > naming them explicitly, eg:
> > 
> > 	interrupt-names = "timint1", "timint2";
> > 	interrupts = <1>, <2>;
> > 
> > 	interrupt-names = "timint1";
> > 	interrupts = <1>;
> > 
> > 	interrupt-names = "timint2";
> > 	interrupts = <2>;
> > 
> > 	interrupt-names = "timintc";
> > 	interrupts = <3>;
> > 
> > But now I see that of_amba_device_create() doesn't do anything about it
> > (platform device would use them as resource name so we could use
> > platform_get_resource_byname), so I'm not sure any more...
> 
> The interrupt-names property should not be required and without it here
> you cannot determine the configuration.

It is not required by the standard interrupt bindings. But it could be
required by the SP804 binding, couldn't it? (like any other property)
"Encoding" the information by specific organization of the field makes
it "invisible to the naked eye".

Not that I have any strong feelings about it.

Pawe?
