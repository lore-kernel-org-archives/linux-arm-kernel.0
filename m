From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 Aug 2009 04:52:05 +0200
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
In-Reply-To: <alpine.LFD.2.00.0908212234150.6044@xanadu.home>
References: <200908220223.50588.marek.vasut@gmail.com>
	<alpine.LFD.2.00.0908212234150.6044@xanadu.home>
Message-ID: <200908220452.05108.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 22. srpna 2009 04:44:00 Nicolas Pitre napsal(a):
> On Sat, 22 Aug 2009, Marek Vasut wrote:
> > Hi,
> >
> > This converts most of the drivers found in drivers/mmc/host to
> > dev_pm_ops. Also, it contains some fixes for the probe/remove functions
> > in some cases.
>
> Are you sure you're actually fixing things?
>
> You replaced platform_driver_probe() calls with
> platform_driver_register() calls, and made the probe functions __devinit
> instead of __init.  Especially when the platform device is unlikely to
> go away or new ones to ever appear, there is no point keeping the
> probe code around after it is done.

Yeah, the __devinit should actually remove the init function when done ... to 
my understanding. Sorry in case I'm wrong.
>
>
> Nicolas
