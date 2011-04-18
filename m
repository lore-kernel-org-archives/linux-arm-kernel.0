From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 18 Apr 2011 23:43:41 +0200
Subject: [PATCH 9/14] PM / Blackfin: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
References: <201103280125.11750.rjw@sisk.pl> <201104172311.59289.rjw@sisk.pl>
	<BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
Message-ID: <201104182343.41702.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 18, 2011, Mike Frysinger wrote:
> On Sun, Apr 17, 2011 at 17:11, Rafael J. Wysocki wrote:
> > Convert some Blackfin architecture's code to using struct syscore_ops
> > objects for power management instead of sysdev classes and sysdevs.
> >
> > This simplifies the code and reduces the kernel's memory footprint.
> > It also is necessary for removing sysdevs from the kernel entirely in
> > the future.
> 
> looks straight forward enough ...
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> 
> > +static struct syscore_ops nmi_syscore_ops = {
> >        .resume         = nmi_wdt_resume,
> >        .suspend        = nmi_wdt_suspend,
> >  };
> 
> a bit sad this couldnt be made const

Well, that would trigger a compiler warning from register_syscore_ops().

However, I'm going to make that change change everywhere at once when all of
the conversions have been made, since it looks like we're only going to have
static syscore_ops.

Thanks,
Rafael
