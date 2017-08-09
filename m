From: briannorris@chromium.org (Brian Norris)
Date: Wed, 9 Aug 2017 16:50:43 -0700
Subject: [PATCH] drm/rockchip: Skip suspend/resume if no display is
 attached
In-Reply-To: <20170809230724.113819-1-mka@chromium.org>
References: <20170809230724.113819-1-mka@chromium.org>
Message-ID: <20170809235041.GA32566@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 04:07:24PM -0700, Matthias Kaehlcke wrote:
> rockchip_drm_sys_suspend/resume() obains a struct drm_device pointer
> from drvdata, the pointer is then dereferenced to obtain private data.
> drvdata is set when a display is bound, on systems without a
> (successfully probed) display drvdata is NULL and the PM functions
> try to dereference a NULL pointer.
> 
> The suspend/resume code relies on a valid drm_device object, skip it if
> the pointer is NULL.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

For the record (I believe you found this already), Jeffy sent the same
patch out (to the wrong mailing lists), but it got applied a bit ago:

https://cgit.freedesktop.org/drm/drm-misc/log/?h=drm-misc-fixes

commit 0fa375e6bc9023211eead30a6a79963c45a563da 
drm/rockchip: Fix suspend crash when drm is not bound
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=0fa375e6bc9023211eead30a6a79963c45a563da

Thanks,
Brian
