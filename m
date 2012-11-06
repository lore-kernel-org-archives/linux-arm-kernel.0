From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Nov 2012 20:35:58 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <20121106183444.GJ30931@mudshark.cambridge.arm.com>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <20121106183444.GJ30931@mudshark.cambridge.arm.com>
Message-ID: <201211062035.58250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Will Deacon wrote:
>     ARM: nommu: remove MMU dependency from ARCH_MULTIPLATFORM
>     
>     ARCH_MULTIPLATFORM is the only way to select ARCH_VEXPRESS, so remove
>     the dependency on MMU and instead use it to predicate the selection of
>     ARM_PATCH_PHYS_VIRT.
>     
>     Although running a multi-platform kernel on a selection of MMU-less
>     targets might not yet be possible, the thing should build and targetting
>     a nommu platform is already a fairly involved exercise.
>     
>     Cc: Arnd Bergmann <arnd@arndb.de>
>     Cc: Pawel Moll <Pawel.Moll@arm.com>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Before we apply this, I should probably do a round of randconfig tests. Right now,
I have a series that fixes all build errors we currently get from randconfig
(which always selects MULTIPLATFORM since it doesn't randomize choice statements),
but I am pretty sure that adding NOMMU into the mix gives us a lot of new errors.

	Arnd
