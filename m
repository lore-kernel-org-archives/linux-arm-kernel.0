From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 22:07:54 +0800
Subject: Sharing resources between several drivers.
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB1F69E@DBDE01.ent.ti.com>
References: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EB1F69E@DBDE01.ent.ti.com>
Message-ID: <20120728140751.GI2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 09:03:33AM +0000, Bedia, Vaibhav wrote:
> On Fri, Jul 27, 2012 at 13:29:21, javier Martin wrote:
> > Hi,
> > we are trying to support pinctrl for i.MX21, i.MX1 and i.MX27.
> > 
> > In these chips, gpio and pinctrl use the same HW memory area
> > registers. This means that we have to request the same memory area
> > from two different drivers (gpio and pinctrl) but we don't know how to
> > do that.
> > 
> > A similar example available is mxs, but it only works with device
> > tree, so this problem is avoided.  However, some of these chips
> 
> I am curious as to how device tree solves the access issues for
> a shared resource.
> 
Although pinctrl and gpio share the same IO region, they are accessing
different registers, so there should be no access issues.

-- 
Regards,
Shawn
