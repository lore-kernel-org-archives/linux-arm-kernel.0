From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Dec 2012 20:17:20 +0100
Subject: [PATCH 0/3] clk: Provide option to unprepare unused clocks at
 late init
In-Reply-To: <1355872583-20928-1-git-send-email-ulf.hansson@stericsson.com>
References: <1355872583-20928-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbCuDxszPZ-VYxhbNUSvyGM=rGw4h5Uy8LfqDcY0V-Dyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 12:16 AM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:

> The disable_unused sequence executed at late init, is already handling the
> fast unused ungated clocks to be gated. This patchset extends this sequence to
> include the slow unused prepared clocks to be unprepared.
>
> The default behavior will not change in this patchset. To unprepare unused
> clocks during the disable_unused sequence, the clk_hw needs to implement
> the new optional callback, is_prepared.
>
> The motivation for this patchset is to save power. Clocks that is from
> bootloaders prepared|enabled, but not used should be unprepared|disabled.

This has a nice symmetrical touch to it and looks allright to me, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
