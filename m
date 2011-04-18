From: vapier@gentoo.org (Mike Frysinger)
Date: Sun, 17 Apr 2011 22:34:22 -0400
Subject: [PATCH 9/14] PM / Blackfin: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <201104172311.59289.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172311.59289.rjw@sisk.pl>
Message-ID: <BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 17, 2011 at 17:11, Rafael J. Wysocki wrote:
> Convert some Blackfin architecture's code to using struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
>
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.

looks straight forward enough ...
Acked-by: Mike Frysinger <vapier@gentoo.org>

> +static struct syscore_ops nmi_syscore_ops = {
> ? ? ? ?.resume ? ? ? ? = nmi_wdt_resume,
> ? ? ? ?.suspend ? ? ? ?= nmi_wdt_suspend,
> ?};

a bit sad this couldnt be made const
-mike
