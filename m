From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jun 2012 08:04:38 +0000
Subject: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
References: <cover.1339447570.git.rubini@gnudd.com>
 <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
Message-ID: <201206140804.39083.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Alessandro Rubini wrote:
> The i2c-nomadik gateware is really a PrimeCell APB device. By hosting
> the driver under the amba bus we can access it more easily, for
> example using the generic pci-amba driver. The patch also fixes the
> mach-ux500 users, so they register an amba device instead than a
> platform device.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/devices-common.h |   22 +----
>  drivers/i2c/busses/i2c-nomadik.c     |  142 +++++++++++++++++----------------
>  2 files changed, 78 insertions(+), 86 deletions(-)

You change only one half of ux500 here: the part where the device gets defined
statically, but not not the definition in the device-tree.

I think all you need to do is mark the device compatible with primecell
and add an ID if necessary, but we should definitely make sure that that
path still works, because the one you patch is going away.

	Arnd
