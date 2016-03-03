From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Mar 2016 09:57:37 -0800
Subject: [PATCH 2/2] mmc: mediatek: Use mmc_regulator_set_vqmmc in
 start_signal_voltage_switch
In-Reply-To: <1457000385-2317-2-git-send-email-drinkcat@chromium.org>
References: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
 <1457000385-2317-2-git-send-email-drinkcat@chromium.org>
Message-ID: <CAD=FV=VSO9S++DNuYDANkYhig7z6hV+ij4RRsJe_uSRY88feeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Thu, Mar 3, 2016 at 2:19 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> We've introduced a new helper in the MMC core:
> mmc_regulator_set_vqmmc().  Let's use this in mtk-sd.  Using this new
> helper has some advantages:
>
>     1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>        VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>        compatibility.
>
>     2. We get rid of a few more warnings when probing unsupported
>        voltages.
>
>     3. We get rid of some non-mediatek specific code in mtk-sd.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>
> Similar to e0848f5d294c703917260a6228cc08b8be46c527
> mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch ,
> where I copied the commit message from.
>
>  drivers/mmc/host/mtk-sd.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
