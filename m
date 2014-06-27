From: nsz@port70.net (Szabolcs Nagy)
Date: Fri, 27 Jun 2014 23:09:31 +0200
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627200949.GQ32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <20140627210931.GT23102@port70.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [2014-06-27 21:09:49 +0100]:
> As I said above, enabling CONFIG_KUSER_HELPERS is known to be an ABI
> break, and it's well documented as such.  The future will be running
> systems without the kuser helpers because on ARMv6 and later, there's
> little point in having them.  In fact, today almost all C libraries
> are built without needing the kuser helpers.

i thought the helpers in the kernel can avoid certain memory
barriers that the userspace has to do on armv6 for atomics
(and those barriers are deprecated on armv7 so i thought the
kuser page was better for portable binaries)

> Due to that, any ARMv5 or earlier CPU will always have the kuser helper
> page.  ARMv6 and later may or may not have the kuser helper page, but
> there you're really building for a different ABI anyway (VFP-based) and
> you also know that you have the thread registers.

so is it expected that the libc makes no attempt to provide
portable binary interface for armv5 and armv6?

ie should musl treat those as different targets?
