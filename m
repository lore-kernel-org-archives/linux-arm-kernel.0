From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 27 Jul 2015 19:36:26 +0200
Subject: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
In-Reply-To: <55B6011C.9070906@codethink.co.uk>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
 <20150723123553.GE7576@n2100.arm.linux.org.uk>
 <20150724001605.GA1453@earth>
 <20150726225145.GF7576@n2100.arm.linux.org.uk>
 <20150727011447.GA23087@earth> <55B6011C.9070906@codethink.co.uk>
Message-ID: <20150727173625.GC22086@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Mon, Jul 27, 2015 at 10:59:56AM +0100, Ben Dooks wrote:
> > I think you missed the part adding the !ARCH_MULTIPLATFORM 
> > dependency in Kconfig for ARM_ERRATA_430973. I only removed the 
> > check in the sourcecode, since it is no longer required with the 
> > dependency being in Kconfig.
> > 
> > So I guess there are 3 options now:
> > 
> > 1. Add !ARCH_MULTIPLATFORM dependency to Kconfig, keep extra check 
> > in the sourcecode 2. Add !ARCH_MULTIPLATFORM dependency to Kconfig,
> > remove extra check in the sourcecode 3. Remove !ARCH_MULTIPLATFORM
> > dependency alltogether
> > 
> > I will send an appropriate patch, if you tell me your preferred 
> > option.
> 
> This isn't the only place ARM_ERRATA_430973 is used, [...]

The dependency on ARM_ERRATA_430973 has been removed from
arch/arm/mm/proc-v7-2level.S in 4.1 (commit id e748994), so
that it always flushes. The only additional places are in the
Nokia N900 boardcode and the N900 pdata-quirk, which are
removed in PATCH 1/3.

So actually it is the only place.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/7c76e4e5/attachment.sig>
