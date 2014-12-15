From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 15 Dec 2014 15:42:23 -0800
Subject: [PATCH v2 1/3] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <1418685929-13096-1-git-send-email-dianders@chromium.org>
References: <1418685929-13096-1-git-send-email-dianders@chromium.org>
Message-ID: <CAL1qeaEGYwTCf0xasMZhGHEDWYhddLAS9jYjdgrccSwnFOc+7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Mon, Dec 15, 2014 at 3:25 PM, Doug Anderson <dianders@chromium.org> wrote:
> This adds logic to the MMC core to set VQMMC.  This is expected to be
> called by MMC drivers like dw_mmc as part of (or instead of) their
> start_signal_voltage_switch() callback.
>
> A few notes:
>
> * When setting the signal voltage to 3.3V we do our best to make VQMMC
>   and VMMC match.  It's been reported that this makes some old cards
>   happy since they were tested back in the day before UHS when VQMMC
>   and VMMC were provided by the same regulator.  A nice side effect of
>   this is that we don't end up on the hairy edge of VQMMC (2.7V),
>   which some EEs claim is a little too close to the minimum for
>   comfort.
>
> * When setting the signal voltage to 1.8V or 1.2V we aim for that
>   specific voltage instead of picking the lowest one in the range.
>
> * We very purposely don't print errors in mmc_regulator_set_vqmmc().
>   There are cases where the MMC core will try several different
>   voltages and we don't want to pollute the logs.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Looks good to me.

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
