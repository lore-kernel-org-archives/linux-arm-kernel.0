From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 24 May 2016 10:28:42 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v5
In-Reply-To: <1464074857-5515-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1464074761-5194-1-git-send-email-tomeu.vizoso@collabora.com>
 <1464074857-5515-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <7363560.k3ytHeYgtM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

Patch subject: please put the version into the brackets, so [PATCH v5] as it 
shouldn't be part of the commit log.

Am Dienstag, 24. Mai 2016, 09:27:37 schrieb Tomeu Vizoso:
> As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
> updated is requested and there is an earlier updated pending".

> v2: Use the status of the workqueue instead of vop->event, and don't add
> a superfluous wait on the workqueue.
> 
> v3: Drop work_busy, as there's a sizeable delay when the worker
> finishes, which introduces a race in which the client has already
> received the last flip event but the next page flip ioctl will still
> return -EBUSY because work_busy returns outdated information.
> 
> v4: Hold dev->event_lock while checking the VOP's event field as
> suggested by Daniel Stone.
> 
> v5: Only block if there's outstanding work if it's a blocking call.

similarly, please put the changelog below the "---" and above the diffstat.


> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---

aka here.

>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 25
> ++++++++++++++++++++++--- drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 
> 6 ++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)

Heiko
