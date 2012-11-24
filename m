From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 24 Nov 2012 11:03:30 +0100
Subject: [PATCH] cpuidle: add Calxeda SOC idle support
In-Reply-To: <201211122200.07901.arnd@arndb.de>
References: <1352330622-13616-1-git-send-email-robherring2@gmail.com>
 <201211122200.07901.arnd@arndb.de>
Message-ID: <2676657.zDjyfqIDdm@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 12, 2012 10:00:07 PM Arnd Bergmann wrote:
> On Wednesday 07 November 2012, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Add support for core powergating on Calxeda platforms. Initially, this
> > supports ECX-1000 (highbank), but support will be added for ECX-2000
> > later.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> > It's not really clear where we want ARM cpuidle drivers. We're moving
> > everything else out of arch/arm, and my understanding is Len doesn't want
> > them in drivers/idle. It seems kind of silly to me to have the framework
> > and drivers in 2 places. I've put this in drivers/cpuidle, but it doesn't
> > make any difference to me.
> 
> Fine with me. I just don't want in in arch/arm because I'm guessing this will
> be shared with arm64, which in turn shares idle (and other) drivers with various
> powerpc, mips and x86 socs.

Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
