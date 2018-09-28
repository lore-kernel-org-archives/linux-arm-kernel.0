From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Sep 2018 22:06:41 +0200
Subject: drivers binding to device node with multiple compatible strings
In-Reply-To: <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
Message-ID: <4c740fb03dec9dbd45264207da96fcd2051e634f.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, den 28.09.2018, 12:43 -0700 schrieb Frank Rowand:
> + Frank
> 
> On 09/27/18 15:25, Li Yang wrote:
> > Hi Rob and Grant,
> > 
> > Various device tree specs are recommending to include all the
> > potential compatible strings in the device node, with the order from
> > most specific to most general.  But it looks like Linux kernel doesn't
> > provide a way to bind the device to the most specific driver, however,
> > the first registered compatible driver will be bound.
> > 
> > As more and more generic drivers are added to the Linux kernel, they
> > are competing with the more specific vendor drivers and causes problem
> > when both are built into the kernel.  I'm wondering if there is a
> > generic solution (or in plan) to make the most specific driver bound
> > to the device.   Or we have to disable the more general driver or
> > remove the more general compatible string from the device tree?

Not really contributing to the solution, but the hard question to
answer is when do you know what the most specific driver is? The most
specific driver might well be a module that can be loaded at any time,
while there might already be other less specific drivers around.

In general I would say that if your device is specific enough to
warrant a whole new driver, it should not declare compatibility with
the generic thing in the compatible, but then this is kind of exporting
an Linux implementation detail to DT.

Regards,
Lucas
