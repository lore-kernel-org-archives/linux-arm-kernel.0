From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 14:29:10 +0200
Subject: [PATCH v2 1/4] arm64,
 thunder: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <20140908110131.GX4703@rric.localhost>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <2952834.1P42roDKD9@wuerfel> <20140908110131.GX4703@rric.localhost>
Message-ID: <8282633.qB60Cj5UPD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 13:01:31 Robert Richter wrote:
> This is well hidden on x86, but each vendor has a config option. For
> AMD systems we have had our own option to disable vendor specific
> code, see CPU_SUP_AMD for example. Disabling this will remove all AMD
> specific code in the kernel. Of course this is enabled per default.
> 
> With ARCH_THUNDER I intended to do the same (you could name this also
> SOC_SUP_CAVIUM or so but I kept the current naming scheme). In patch
> 4/4 I have added the option to defconfig. This enables this per
> default and nobody has to deal with any option manually, just running
> make defconfig is fine.
> 
> Also, at least to disable building the dtb file for foo, you will need
> ARCH_FOO too. How else would you deal with dtb files then?

The only alternative I see is to build them all.

> Having ARCH_FOO might not be necessary for drivers. One could enable
> drivers manually, but this option is still a good reference for the
> drivers needed by foo. At some point you will carry tons of enabled
> drivers in your defconfig and you don't know which platform actually
> is using it. For generic drivers this might be fine.  But in my point
> of few, each soc specific driver should have an soc specific option
> too. Then you easily can remove an soc from the defconfig.

Yes, that's what I had in my example.

	Arnd
