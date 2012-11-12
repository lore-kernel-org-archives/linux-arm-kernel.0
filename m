From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 22:00:07 +0000
Subject: [PATCH] cpuidle: add Calxeda SOC idle support
In-Reply-To: <1352330622-13616-1-git-send-email-robherring2@gmail.com>
References: <1352330622-13616-1-git-send-email-robherring2@gmail.com>
Message-ID: <201211122200.07901.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 November 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add support for core powergating on Calxeda platforms. Initially, this
> supports ECX-1000 (highbank), but support will be added for ECX-2000
> later.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> It's not really clear where we want ARM cpuidle drivers. We're moving
> everything else out of arch/arm, and my understanding is Len doesn't want
> them in drivers/idle. It seems kind of silly to me to have the framework
> and drivers in 2 places. I've put this in drivers/cpuidle, but it doesn't
> make any difference to me.

Fine with me. I just don't want in in arch/arm because I'm guessing this will
be shared with arm64, which in turn shares idle (and other) drivers with various
powerpc, mips and x86 socs.

	Arnd
