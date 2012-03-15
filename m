From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Mar 2012 09:56:27 -0700
Subject: [PATCH 5/6] ARM: OMAP2+: I2C: always compile I2C reset code,
 even if I2C driver is not built
In-Reply-To: <E1S87xA-0000N4-2z@rmk-PC.arm.linux.org.uk>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
 <E1S87xA-0000N4-2z@rmk-PC.arm.linux.org.uk>
Message-ID: <20120315165626.GX12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120315 03:33]:
> During kernel init, we reset all IP blocks on the OMAP that we can,
> even if there is no driver compiled for that IP block.  Unlike most IP
> blocks, the I2C block requires some extra programming for this to
> work.  This reset code is incorrectly omitted when the I2C driver is
> deselected.  In this circumstance, the build breaks.  Fix by compiling
> the I2C reset code unconditionally.

This one is commit ed8dfd22ea2533a1b169881c3de94be8daa0e297 in
arm-soc/for-next.

Regards,

Tony
