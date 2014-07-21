From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jul 2014 14:51:38 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <20140721143813.6028b6ed@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <53CD08CF.6080900@linaro.org> <20140721143813.6028b6ed@free-electrons.com>
Message-ID: <19699239.33i4BRP9GE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 July 2014 14:38:13 Thomas Petazzoni wrote:
> Dear Daniel Lezcano,
> 
> On Mon, 21 Jul 2014 14:34:23 +0200, Daniel Lezcano wrote:
> 
> > So there are three solutions:
> > 
> > 1. Pass the flag through the platform data, I am not really in favor of 
> > that as mentioned above
> 
> That's what is already implemented.

It's certainly better than checking a global compatible string in
driver code, IMHO.

Instead of a global header file, I would have put the structure
definition under linux/platform-data, as we do for most other
legacy drivers.

> > 2. Use the compatible string like the cpuidle-big-little.c driver, but 
> > Arnd is not in favor of that
> > 
> > 3. Register 3 platform drivers, in cpuidle-mvebu-v7.c, and let the 
> > registering of the cpuidle's platform device to enable the right one
> 
> I'm fine with doing (3). Daniel, Arnd, let me know if that's ok for
> you, and I'll respin the patch series accordingly.

If I understood Daniel correctly, this is temporary anyway until
we have a proper binding, right?

If so, I don't really mind either approach.

	Arnd
