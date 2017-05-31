From: john.stultz@linaro.org (John Stultz)
Date: Wed, 31 May 2017 11:14:22 -0700
Subject: [PATCH 8/8] arm64: dts: hikey: Fix WiFi support
In-Reply-To: <1494260477-25163-9-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-9-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CALAqxLX4HwbVm8G4Ch2uYKAy6C9vYAZEcRUdCLDePT55oGz6hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 9:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The description of the connection between the dwmmc (SDIO) controller and
> the Wifi chip, which is attached to the SDIO bus is wrong. Currently the
> SDIO card can't be detected and thus the Wifi doesn't work.
>
> Let's fix this by assigning the correct vmmc supply, which is the always on
> regulator VDD_3V3 and remove the WLAN enable regulator altogether. Then to
> properly deal with the power on/off sequence, add a mmc-pwrseq node to
> describe the resources needed to detect the SDIO card.
>
> Except for the WLAN enable GPIO and its corresponding assert/de-assert
> delays, the mmc-pwrseq node also contains a handle to a clock provided by
> the hi655x pmic. This clock is also needed to be able to turn on the WiFi
> chip.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>


Ulf,
  So oddly, this patch seems to have broken wifi on HiKey when it
landed in 4.12-rc3. I checked my config and CONFIG_PWRSEQ_SIMPLE is
enabled.

Reverting this patch seems to get things working again for me.

thanks
-john
