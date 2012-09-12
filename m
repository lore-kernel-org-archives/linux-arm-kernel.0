From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 12 Sep 2012 12:06:03 +0300
Subject: [PATCH] rpmsg: use right device paramter when calling
 dma_free_coherent function
In-Reply-To: <1346286292-21773-1-git-send-email-fernando.lugo@ti.com>
References: <1346286292-21773-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <CAK=WgbYg_j_Ym2RBX_pX0RaSEh9KiPHUmieqyVwNV+JVEcvEGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fernando,

On Thu, Aug 30, 2012 at 3:24 AM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> dma_alloc/free_coherent APIs requires the platform specific remoteproc
> device as the device parameter. We are passing vdev->dev.parent to the
> dma_free_coherent function which is the generic rproc device and it is
> wrong, it has to be vdev->dev.parent->parent instead, same as when we
> call dma_alloc_coherent function.
>
> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>

Thanks, applied to rpmsg-fixes.

Ohad.
