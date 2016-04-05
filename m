From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 5 Apr 2016 13:12:33 +0200
Subject: [PATCH v3 0/5] davinci_mmc fixes
In-Reply-To: <1458186341-6970-1-git-send-email-david@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
Message-ID: <CAPDyKFp3UELfw2gNTh0GeX31bjwb8tbDiua6ZigLwhaUkcv3zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2016 at 04:45, David Lechner <david@lechnology.com> wrote:
> I have replaced one of my patches with the patch from Peter Ujfalusi and fixed
> a mistake in the "fix unwinding..." patch.
>
> Tested working on LEGO MINDSTORMS EV3 (da850-ish).
>
> David Lechner (4):
>   mmc: davinci: remove matching string
>   mmc: davinci: fix unwinding in probe
>   mmc: davinci: prepare clock
>   ARM: davinci: remove mmc dma resources
>
> Peter Ujfalusi (1):
>   mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel
>
>  arch/arm/mach-davinci/devices-da8xx.c |  20 -----
>  arch/arm/mach-davinci/devices.c       |  16 ----
>  drivers/mmc/host/davinci_mmc.c        | 147 ++++++++++++----------------------
>  3 files changed, 50 insertions(+), 133 deletions(-)
>
> --
> 1.9.1
>

Patch 3 triggers a compiler warning, please fix it.

../drivers/mmc/host/davinci_mmc.c: In function ?davinci_mmcsd_probe?:
../drivers/mmc/host/davinci_mmc.c:1208:6: warning: ?ret? may be used
uninitialized in this function [-Wmaybe-uninitialized]

I have applied patch 1->2 for next, so no need to resend these.

Kind regards
Uffe
