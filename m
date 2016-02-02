From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 2 Feb 2016 14:11:25 +0100
Subject: [PATCH 0/3] mmc: sunxi: Support eMMC DDR modes
In-Reply-To: <1454088108-2332-1-git-send-email-wens@csie.org>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Message-ID: <CAPDyKFrH80eb3dC=AuxXHBHhk-P7puGtModHEmfywRXskVmWQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2016 at 18:21, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This was "mmc: sunxi: Support vqmmc regulator and eMMC DDR modes". vqmmc
> support and DT patches were merged even though it was an RFC series, to
> my suprise.
>
> These are the remaining patches that add eMMC HS-DDR support to sunxi.
>
> Patch 1 adds timing delays for MMC_DDR52 mode.
>
> Patch 2 adds support for 8 bit eMMC DDR52 mode. Under this mode, the
> controller must run at twice the card clock, and different timing delays
> are needed.
>
> Patch 3 enables eMMC HS-DDR for sunxi-mmc.
>
>
> Changes since RFC:
>
>   - Dropped patches that are merged
>
>   - Dropped "mmc: sunxi: Block signal voltage switching (CMD11)".
>     According to Ulf, the mmc core won't send this command unless the UHS
>     capabilities are set. We don't.
>
>   - Increased f_max to 52 MHz. Clock rate range for 50 MHz timing delay
>     also increased to match. See patch 1.
>
>
> Regards
> ChenYu
>
>
> Chen-Yu Tsai (3):
>   mmc: sunxi: Support MMC_DDR52 timing modes
>   mmc: sunxi: Support 8 bit eMMC DDR transfer modes
>   mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support
>
>  drivers/mmc/host/sunxi-mmc.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> --
> 2.7.0
>

Thanks, applied for next!

Kind regards
Uffe
