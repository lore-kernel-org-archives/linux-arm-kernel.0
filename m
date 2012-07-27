From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 27 Jul 2012 09:03:33 +0000
Subject: Sharing resources between several drivers.
In-Reply-To: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
References: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB1F69E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 13:29:21, javier Martin wrote:
> Hi,
> we are trying to support pinctrl for i.MX21, i.MX1 and i.MX27.
> 
> In these chips, gpio and pinctrl use the same HW memory area
> registers. This means that we have to request the same memory area
> from two different drivers (gpio and pinctrl) but we don't know how to
> do that.
> 
> A similar example available is mxs, but it only works with device
> tree, so this problem is avoided.  However, some of these chips

I am curious as to how device tree solves the access issues for
a shared resource.

> (i.MX21, i.MX1...) don't support device tree yet, so we need to
> provide backwards compatibility.
> 
> What is the right way to request the same memory region from two
> different drivers? Moreover, how can we guarantee that there won't be
> any conflicts when accessing these shared resources?
> 

For a few registers this might be an overkill but MFD comes to mind.

Regards,
Vaibhav B.
