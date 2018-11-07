From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 08:20:25 -0800
Subject: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
In-Reply-To: <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 6:44 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@exceet.de>
>
> The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
> at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>

Hi Frieder,

This patch is part of a series that I didn't see the rest of, but in
general we prefer to merge these through arm-soc even if the driver
goes in through another tree. The way we'd prefer to handle it is that
once the driver lands, we'll take the config option change to turn it
on. To avoid our branches to break until both sides have landed, it
might be a good idea to keep both drivers on for a short while (one
release).

So, I'm not going to ack this since we avoid taking defconfig changes
through driver trees (these two defconfigs tend to churn a lot and we
don't want to create merge conflicts where we don't have to), but
we'll be happy to pick it up when the time comes.


Thanks,

-Olof
