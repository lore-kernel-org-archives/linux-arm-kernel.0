From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Nov 2012 17:44:26 +0000
Subject: [PATCH V7 1/7] kbuild: centralize .dts->.dtb rule
In-Reply-To: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121128174426.GD17405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 11:29:10PM +0000, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> All architectures that use cmd_dtc do so in almost the same way. Create
> a central build rule to avoid duplication. The one difference is that
> most current uses of dtc build $(obj)/%.dtb from $(src)/dts/%.dts rather
> than building the .dtb in the same directory as the .dts file. This
> difference will be eliminated arch-by-arch in future patches.
> 
> MIPS is the exception here; it already uses the exact same rule as the
> new common rule, so the duplicate is removed in this patch to avoid any
> conflict. arch/mips changes courtesy of Ralf Baechle.
> 
> Update Documentation/kbuild to remove the explicit call to cmd_dtc from
> the example, now that the rule exists in a centralized location.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux at lists.openrisc.net
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: linux-c6x-dev at linux-c6x.org
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: microblaze-uclinux at itee.uq.edu.au
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-xtensa at linux-xtensa.org
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
