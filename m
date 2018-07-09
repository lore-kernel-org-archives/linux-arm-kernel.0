From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 9 Jul 2018 16:01:10 +0200
Subject: [PATCH] ARM: tegra: Fix Tegra30 Cardhu PCA954x reset
In-Reply-To: <1530608387-9591-1-git-send-email-jonathanh@nvidia.com>
References: <1530608387-9591-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20180709140110.GA18353@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 09:59:47AM +0100, Jon Hunter wrote:
> On all versions of Tegra30 Cardhu, the reset signal to the NXP PCA9546
> I2C mux is connected to the Tegra GPIO BB0. Currently, this pin on the
> Tegra is not configured as a GPIO but as a special-function IO (SFIO)
> that is multiplexing the pin to an I2S controller. On exiting system
> suspend, I2C commands sent to the PCA9546 are failing because there is
> no ACK. Although it is not possible to see exactly what is happening
> to the reset during suspend, by ensuring it is configured as a GPIO
> and driven high, to de-assert the reset, the failures are no longer
> seen.
> 
> Please note that this GPIO is also used to drive the reset signal
> going to the camera connector on the board. However, given that there
> is no camera support currently for Cardhu, this should not have any
> impact.
> 
> Fixes: 40431d16ff11 ("ARM: tegra: enable PCA9546 on Cardhu")
> 
> Cc: stable at vger.kernel.org
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra30-cardhu.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.19/arm/dt, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/eac7cd6c/attachment.sig>
