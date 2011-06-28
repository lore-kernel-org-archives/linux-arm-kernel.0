From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 00:24:29 +0100
Subject: [PATCH 2/4] ARM: remove unnecessary mach/hardware.h includes
In-Reply-To: <1309301859-17651-3-git-send-email-robherring2@gmail.com>
References: <1309301859-17651-1-git-send-email-robherring2@gmail.com>
	<1309301859-17651-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110628232429.GI21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 05:57:37PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Remove some includes of mach/hardware.h which are not needed. hardware.h will
> be removed completely for tegra and cns3xxx in follow on patch.

At least this one is incorrect:

arch/arm/mach-rpc/include/mach/hardware.h:#define IO_EC_MEMC_BASE              0x80000000
arch/arm/kernel/ecard.c:                    address = IO_EC_MEMC_BASE + (slot << 12);

That's just one of the defines that ecard.c uses from mach/hardare.h.
