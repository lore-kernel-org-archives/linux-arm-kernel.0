From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 15 Dec 2014 17:12:52 -0800
Subject: [PATCH v3 2/3] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
 start_signal_voltage_switch
In-Reply-To: <1418689340-29517-2-git-send-email-dianders@chromium.org>
References: <1418689340-29517-1-git-send-email-dianders@chromium.org>
 <1418689340-29517-2-git-send-email-dianders@chromium.org>
Message-ID: <CAL1qeaHaNibn9pVdy4+2uWa+EC5FnoF5cuz9HdXD6CmiiBribg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

On Mon, Dec 15, 2014 at 4:22 PM, Doug Anderson <dianders@chromium.org> wrote:
> We've introduced a new helper in the MMC core:
> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
> helper has some advantages:
>
> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>    compatibility.
>
> 2. We get rid of a few more warnings when probing unsupported
>    voltages.
>
> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
