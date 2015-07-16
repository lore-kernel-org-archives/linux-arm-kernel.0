From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jul 2015 23:48:54 -0700
Subject: [PATCH 4/4] ARM: omap2: restore OMAP4 barrier behaviour
In-Reply-To: <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmM-0006GN-5Y@rmk-PC.arm.linux.org.uk>
Message-ID: <20150716064854.GG17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Russell King <rmk+kernel@arm.linux.org.uk> [150715 10:50]:
> Restore the OMAP4 barrier behaviour using the new implementation which
> allows multiplatform systems to hook into the mb() and wmb() ARM
> implementations to perform any necessary additional barrier maintanence.

I'm getthing this with omap2plus_defconfig with the last patch
applied:

arch/arm/mach-omap2/omap4-common.c: In function ?omap4_sram_init?:
arch/arm/mach-omap2/omap4-common.c:138:14: error: implicit declaration of function ?of_get_named_gen_pool? [-Werror=implicit-function-declaration]
  sram_pool = of_get_named_gen_pool(np, "sram", 0);
              ^
arch/arm/mach-omap2/omap4-common.c:138:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  sram_pool = of_get_named_gen_pool(np, "sram", 0);
            ^
Regards,

Tony
