From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 7 Feb 2017 13:19:09 +0100
Subject: [PATCH v2 3/7] drm/rockchip: gem: add mutex lock for drm mm
In-Reply-To: <1486456542-18675-4-git-send-email-mark.yao@rock-chips.com>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
 <1486456542-18675-4-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170207121909.GA18315@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 04:35:38PM +0800, Mark Yao wrote:
> drm_mm_insert_node_generic and drm_mm_remove_node may access same
> resource with list ops, it's not threads safe, so protect this context
> with mutex lock.
> 
> Fix bug:
> [49451.856244] ==================================================================
> [49451.856350] BUG: KASAN: wild-memory-access on address dead000000000108
> [49451.856379] Write of size 8 by task Binder:218_4/683
> [49451.856417] CPU: 2 PID: 683 Comm: Binder:218_4 Not tainted 4.4.36 #62
> [49451.856443] Hardware name: Rockchip RK3399 Excavator Board edp (Android) (DT)
> [49451.856469] Call trace:
> [49451.856519] [<ffffff900808a9d0>] dump_backtrace+0x0/0x230
> [49451.856556] [<ffffff900808ac14>] show_stack+0x14/0x1c
> [49451.856592] [<ffffff90084a4de0>] dump_stack+0xa0/0xc8
> [49451.856633] [<ffffff900821b700>] kasan_report+0x110/0x4dc
> [49451.856670] [<ffffff900821aa84>] __asan_store8+0x24/0x7c
> [49451.856715] [<ffffff90086158c4>] drm_mm_insert_node_generic+0x2dc/0x464
> [49451.856760] [<ffffff90086406a8>] rockchip_gem_iommu_map+0x60/0x158
> [49451.856794] [<ffffff9008640bb4>] rockchip_gem_create_object+0x278/0x488
> [49451.856827] [<ffffff9008641020>] rockchip_gem_create_with_handle+0x24/0x10c
> [49451.856862] [<ffffff9008641364>] rockchip_gem_create_ioctl+0x3c/0x50
> [49451.856896] [<ffffff900860aee4>] drm_ioctl+0x354/0x52c
> [49451.856939] [<ffffff900823d948>] do_vfs_ioctl+0x670/0x78c
> [49451.856976] [<ffffff900823dac4>] SyS_ioctl+0x60/0x88
> [49451.857009] [<ffffff9008082ef0>] el0_svc_naked+0x24/0x28
> 
> Change-Id: I2ea377aa9ca24f70c59e2d86f2a6ad5ccb9c0891

This is meaningless in an upstream tree. Please remove.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/41ac3c5b/attachment.sig>
