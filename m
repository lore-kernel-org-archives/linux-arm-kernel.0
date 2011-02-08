From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 8 Feb 2011 12:22:06 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <201102081311.52004.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<20110208110808.GA22877@n2100.arm.linux.org.uk>
	<201102081311.52004.arnd@arndb.de>
Message-ID: <20110208122205.GA5903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> > > For v6, wfi is architected as a defined MCR instruction, so
> > > use that definition.

[...]

On Tue, Feb 08, 2011 at 01:11:51PM +0100, Arnd Bergmann wrote:
> I don't see any users of the sev/wfe/wfi macros in the current kernel,
> so removing them seems like a good strategy to avoid people from
> using them incorrectly.
> 
> If the definitions differ between v5/v6/v7 CPUs, any common code
> using them would need to do either binary patching of some sort
> or abstract the difference between the CPU in some other way.
> 
> Dave, what code do you have in mind as a possible user?

The OMAP BSP has its own version of this, which I'm suggesting
to port to the more generic macros in system.h, now that they
exist.

---Dave
