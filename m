From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 15 Jul 2012 12:10:17 +0300
Subject: [PATCH] remoteproc: allocate vrings on demand,
 free when not needed
In-Reply-To: <1337515228-31910-1-git-send-email-ohad@wizery.com>
References: <1337515228-31910-1-git-send-email-ohad@wizery.com>
Message-ID: <CAK=WgbZVUEWErthGz0ch-fFkZAEMU0unqPPXCZ5AXVa-8a3=_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2012 at 3:00 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Dynamically allocate the vrings' DMA when the remote processor
> is about to be powered on (i.e. when ->find_vqs() is invoked),
> and release them as soon as it is powered off (i.e. when ->del_vqs()
> is invoked).
>
> The obvious and immediate benefit is better memory utilization, since
> memory for the vrings is now only allocated when the relevant remote
> processor is being used.
>
> Additionally, this approach also makes recovery of a (crashing)
> remote processor easier: one just needs to remove the relevant
> vdevs, and the entire vrings cleanup takes place automagically.
>
> Tested-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     |  109 +++++++++++++++---------------
>  drivers/remoteproc/remoteproc_internal.h |    2 +
>  drivers/remoteproc/remoteproc_virtio.c   |   13 +++-
>  3 files changed, 67 insertions(+), 57 deletions(-)

Applied.
