From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 7 Feb 2017 22:05:39 +0900
Subject: [PATCH v2 7/7] drm/rockchip: Call drm_gem_object_release() to
 destroy GEM base
In-Reply-To: <20170207123707.GC18315@ulmo.ba.sec>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
 <1486456773-19233-1-git-send-email-mark.yao@rock-chips.com>
 <20170207123707.GC18315@ulmo.ba.sec>
Message-ID: <CAAFQd5DX9fTzKr8OA8eFs6QN2Mb2cSTSJCwgy3_Wd=ioxJ1oOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Feb 7, 2017 at 9:37 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Feb 07, 2017 at 04:39:33PM +0800, Mark Yao wrote:
>> From: Tomasz Figa <tfiga@chromium.org>
>>
>> When converting the driver to use shmem-backed GEMs for IOMMU-enabled
>> systems, we forgot to add calls to drm_gem_object_release(), which gave
>> us a quite nice memory leak. This patch adds the missing calls.
>>
>> Fixes: f11d5f0 ("FROMLIST: drm/rockchip: Do not use DMA mapping API if
>> attached to IOMMU domain")

Since the patch being fixed is also a part of this series, the fix
could be just squashed directly (with sign-off lists merged). Same for
patch 6/7.

Best regards,
Tomasz
