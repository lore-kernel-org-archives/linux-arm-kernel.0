From: dianders@chromium.org (Doug Anderson)
Date: Mon, 6 Oct 2014 11:11:05 -0700
Subject: [PATCH] mmc: dw_mmc: Reset DMA before enabling IDMAC
In-Reply-To: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
References: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <CAD=FV=W-GW0c8m_5Oaet=ZhJJwmk4RWJ7QurcySB7T8YvKr6Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sonny,

On Mon, Oct 6, 2014 at 10:53 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
> We've already got a reset of DMA after it's done.  Add one before we
> start DMA too.  This fixes a data corruption on Rockchip SoCs which
> will get bad data when doing a DMA transfer after doing a PIO transfer.
>
> We tested this on an Exynos 5800 with HS200 and didn't notice any
> difference in sequential read throughput.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
