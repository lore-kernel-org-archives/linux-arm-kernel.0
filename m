From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Nov 2014 08:08:36 -0800
Subject: [GIT PULL 2/3] omap gpmc changes for v3.19
In-Reply-To: <201411201202.41698.arnd@arndb.de>
References: <pull-1415814409-868361> <pull-1415814409-868361-2>
 <201411201202.41698.arnd@arndb.de>
Message-ID: <20141120160836.GO7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [141120 03:04]:
> On Wednesday 12 November 2014, Tony Lindgren wrote:
> > GPMC (General Purpose Memory Controller) changes for omaps. These
> > changes allow us to drop dependencies to bootloader timings now
> > that the known device tree entries have been fixed. So we can now
> > require proper timings to be configured and get rid of the legacy
> > smsc91x code.
> > 
> > Note that this branch has a dependency to the related device tree
> > branch sent in a separate pull request as timings are now required.
> 
> Does this mean you are breaking compatibility with old dtb files?
> 
> Can you be more specific which machines are affected?

Not breaking compability. We had timings missing in the .dts files
for a few devices that caused all kinds of hacks in the GPMC code.

Now those are all fixed up and we are actually using the bindings.

Regards,

Tony
