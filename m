From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Dec 2012 19:37:52 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121204172424.GG5314@mudshark.cambridge.arm.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <20121204163555.GH14363@n2100.arm.linux.org.uk>
 <20121204172424.GG5314@mudshark.cambridge.arm.com>
Message-ID: <201212041937.53046.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 December 2012, Will Deacon wrote:
> > 
> > Most other real-world platforms out there have a way to power off the
> > unused secondary CPUs - Tegra and OMAP both do.
> 
> If a virtual machine powers off a virtual CPU, I doubt we want to power of
> its corresponding CPU -- that logic can remain in the host. All we need to
> do is kill the virtual CPU thread, which we can do easily enough. Booting is
> the more difficult problem because we introduce a reliance on a virtual
> device being ready incredibly early, essentially hardcoding part of the
> virtual machine.

Powering off a virtual CPU is the same as killing the virtual CPU thread.
Not powering it off would imply that we schedule a host CPU to run an
endless loop on it.

	Arnd
