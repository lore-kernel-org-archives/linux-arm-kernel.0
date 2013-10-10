From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 10 Oct 2013 15:28:40 -0700
Subject: [GIT PULL] Keystone SOC updates for v3.13
In-Reply-To: <1381267740-31874-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Tue, 8 Oct 2013 17:29:00 -0400")
References: <1381267740-31874-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87wqlkn4kn.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Olof,
>
> Please pull below Keystone SOC updates for v3.13. As discussed on irc, the
> pull request is build on top of v3.13-rc4 because of dependent commit
> c2b9e974{dma/Kconfig: Make TI_EDMA select TI_PRIV_EDMA}. The pull request
> carries Kconfig update patch {dma: Allow TI_EDMA selectable for ARCH_KEYSTONE}
> with Vinod Koul's ack as per alignment on the mailing list[1]. The clock
> driver support is already applied by Mike to his 3.13 clk-next [2]
>
> The following changes since commit ef887009524c3631d804a2587ec204c4ff61a5b8:
>
>   ARM: keystone: Enable I2C and SPI bus support (2013-10-08 15:37:41 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc
>
> for you to fetch changes up to ef887009524c3631d804a2587ec204c4ff61a5b8:
>
>   ARM: keystone: Enable I2C and SPI bus support (2013-10-08 15:37:41 -0400)
>
> ----------------------------------------------------------------
> SOC updates for Keystone II devices:
>
> - Clock tree support
> - Clock management support using PM core
> - Keystone config update for EMDA with ack from Vinod
> - Enable SPI and I2C drivers
>
> ----------------------------------------------------------------
>
> Santosh Shilimkar (9):
>   ARM: dts: keystone: Add clock tree data to devicetree
>   ARM: dts: keystone: Add clock phandle to UART nodes
>   ARM: keystone: Enable clock drivers
>   ARM: keystone: add PM bus support for clock management

I still don't like this one.  Like I pointed out earlier[1], this
doesn't really have anything to do with a bus, so it doesn't belong in
drivers/bus (and the 'bus' naming throughout isn't right.)  IMO, it
belongs in mach-keystone as the platform glue telling how the PM domains
are hooked up on keystone.

Please move it to mach-keystone, and s/pm_bus/pm_domain/ throughout
since it has nothing to do with bus.  The 'bus' naming in davinci is
leftover from the pre-pm_domain days when we were overriding functions
of the platform_bus.

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/196026.html
