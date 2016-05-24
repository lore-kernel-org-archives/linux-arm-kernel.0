From: daniel@fooishbar.org (Daniel Stone)
Date: Tue, 24 May 2016 09:34:50 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v5
In-Reply-To: <1464074857-5515-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1464074761-5194-1-git-send-email-tomeu.vizoso@collabora.com>
 <1464074857-5515-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAPj87rPfakpstxmK3rodunVp2aX-gkLqoqQJ+gfoazaH0ej29g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2016 at 09:27, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
> updated is requested and there is an earlier updated pending".
>
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
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
