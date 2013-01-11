From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Fri, 11 Jan 2013 10:31:46 +0200
Subject: [PATCH 1/2 V3] iio: mxs: Implement support for touchscreen
In-Reply-To: <1357861431-8978-1-git-send-email-marex@denx.de>
References: <1357861431-8978-1-git-send-email-marex@denx.de>
Message-ID: <50EFCDF2.7090207@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/11/2013 01:43 AM, Marek Vasut wrote:
> This patch implements support for sampling of a touchscreen into
> the MXS LRADC driver. The LRADC block allows configuring some of
> it's channels into special mode where they either output the drive
> voltage or sample it, allowing it to operate a 4-wire or 5-wire
> resistive touchscreen.
>
> In case the touchscreen mode is enabled, the LRADC slot #7 is
> reserved for touchscreen only, therefore it is not possible to
> sample 8 LRADC channels at time, but only 7 channels.
>
> The touchscreen controller is configured such that the PENDOWN event
> disables touchscreen interrupts and triggers execution of worker
> thread, which then polls the touchscreen controller for X, Y and
> Pressure values. This reduces the overhead of interrupt-driven
> operation. Upon the PENUP event, the worker thread re-enables the
> PENDOWN detection interrupt and exits.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>   .../bindings/staging/iio/adc/mxs-lradc.txt         |    6 +
>   drivers/staging/iio/adc/mxs-lradc.c                |  473 +++++++++++++++++++-
>   2 files changed, 455 insertions(+), 24 deletions(-)

Works fine with apx4devkit.

Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>

Best Regards,
Lauri Hintsala
