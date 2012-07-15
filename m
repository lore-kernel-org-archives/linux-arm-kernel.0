From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 15 Jul 2012 12:17:01 +0300
Subject: [PATCH 2/2] remoteproc: remove the now-redundant kref
In-Reply-To: <1338017791-9442-2-git-send-email-ohad@wizery.com>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com>
 <1338017791-9442-2-git-send-email-ohad@wizery.com>
Message-ID: <CAK=WgbZdaBCC8xc1iDRtoFLy=5nY4vsGWtZwYusvH4x8qjpcQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2012 at 10:36 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Now that every rproc instance contains a device, we don't need a
> kref anymore to maintain the refcount of the rproc instances:
> that's what device are good with!
>
> This patch removes the now-redundant kref, and switches to
> {get, put}_device instead of kref_{get, put}.
>
> We also don't need the kref's release function anymore, and instead,
> we just utilize the class's release handler (which is now responsible
> for all memory de-allocations).
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/remoteproc/remoteproc_core.c   |   59 +++++++++++---------------------
>  drivers/remoteproc/remoteproc_virtio.c |    8 ++--
>  include/linux/remoteproc.h             |    3 --
>  3 files changed, 24 insertions(+), 46 deletions(-)

Applied (after moving the kerneldoc for rproc_class_release() to the
patch where that function was introduced).
