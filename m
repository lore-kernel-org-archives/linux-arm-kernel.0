From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Nov 2012 17:36:40 +0000
Subject: Building for MMU-less vexpress targets
Message-ID: <20121105173640.GR3351@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I was playing around with !CONFIG_MMU today and to my dismay noticed that
you can't select ARCH_VEXPRESS without CONFIG_MMU=y! This is because
ARCH_VEXPRESS is only selectable via ARCH_MULTI_V7, which depends on
ARCH_MULTIPLATFORM which in turn depends on MMU.

I'm inclined to add a dummy VEXPRESS entry to arm/Kconfig which depends on
!ARCH_MULTIPLATFORM and just selects ARCH_VEXPRESS (with the if ARCH_MULTI_V7
dependency dropped) but I wondered if you'd got any better ideas?

Cheers,

Will
