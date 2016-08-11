From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Aug 2016 22:29:03 +0200
Subject: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <20160811163003.GD18366@e104818-lin.cambridge.arm.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <6457502.FRufylo3sd@wuerfel>
 <20160811163003.GD18366@e104818-lin.cambridge.arm.com>
Message-ID: <2034620.lN3lAEBAXs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 11, 2016 5:30:03 PM CEST Catalin Marinas wrote:

> > > > and you can have ARM binaries with
> > > > PER_LINUX (using the arm64 uname) just like you can have
> > > > arm64 binaries running with PER_LINUX32.
> > > 
> > > I was actually looking to enforce the 32-bit binaries to only see
> > > PER_LINUX32, though with a risk of breaking the ABI. OTOH, people are
> > > abusing this and write 32-bit apps relying on the 64-bit /proc/cpuinfo:
> > > 
> > > http://lkml.kernel.org/g/1464706504-25224-3-git-send-email-catalin.marinas at arm.com
> > > 
> > > (you were summoned on that discussion couple of times ;))
> > 
> > Hmm, I thought I saw the thread and didn't have any good idea for
> > the uname information, but didn't notice it was for /proc/cpuinfo.
> > 
> > What's wrong with always showing both the 32-bit and the 64-bit
> > hwcap strings here (minus the duplicates, which hopefully have
> > the same meaning here)?
> 
> As I said above, some of them have the same name (which may be a good
> thing at a first look) but we don't have an architecture guarantee that
> the feature is present in both AArch32 and AArch64 modes (e.g. AES may
> only be available in AArch64).

Is this the case on actual implementations that exist today? If they
are actually always both present, we might be able to get away with it.

	Arnd
