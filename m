From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 27 Sep 2012 23:53:33 -0400 (EDT)
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <50632096.7080208@wwwdotorg.org>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <201209261417.18883.arnd@arndb.de> <506315A6.3090300@am.sony.com>
 <201209261449.48468.arnd@arndb.de>
 <20120926151023.GC30938@n2100.arm.linux.org.uk>
 <50632096.7080208@wwwdotorg.org>
Message-ID: <alpine.LFD.2.02.1209272343330.6667@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Sep 2012, Stephen Warren wrote:

> In the Tegra case, by omitting uncompress.h, we lose more than just the
> "Decompressing Linux..." message; uncompress.h contains code to parse
> extract the platform's debug UART ID from data set up by the boot ROM
> (since we have 5 UARTs), and pass this on to debug-macro.S.

Let me tell you that this is totally evil.  OMAP and Davinci are doing 
the same abuse.

> Without uncompress.h running, debug-macro.S would either have to 
> hard-code a single UART ID (and different boards uses different UARTs, 
> which would make running a single kernel image across all Tegra 
> devices with earlyprintk enabled impossible) *or* we'd have to port 
> the UART ID extraction code to debug-macro.S too,

Please do the later.  That's the only sane solution.

> which I don't fancy very much since that's assembly whereas 
> uncompress.h is C.

Well, that's too bad.  Time to sharpen your assembly skills.  ;-)


Nicolas
