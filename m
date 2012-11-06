From: cjb@laptop.org (Chris Ball)
Date: Tue, 06 Nov 2012 17:15:31 -0500
Subject: [PATCH 6/8] mmc: dw_mmc: constify dw_mci_idmac_ops in exynos
 back-end
In-Reply-To: <1352238933-4886-7-git-send-email-arnd@arndb.de> (Arnd Bergmann's
 message of "Tue, 6 Nov 2012 22:55:31 +0100")
References: <1352238933-4886-1-git-send-email-arnd@arndb.de>
 <1352238933-4886-7-git-send-email-arnd@arndb.de>
Message-ID: <87hap28jjw.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Nov 06 2012, Arnd Bergmann wrote:
> The of_device_id match data is now marked as const and
> must not be modified. This changes the dw_mmc to mark
> all pointers passing the dw_mci_drv_data or dw_mci_dma_ops
> structures as const, and also marks the static definitions
> as const.
>
> drivers/mmc/host/dw_mmc-exynos.c: In function 'dw_mci_exynos_probe':
> drivers/mmc/host/dw_mmc-exynos.c:234:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Will Newton <will.newton@imgtec.com>
> Cc: Chris Ball <cjb@laptop.org>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
