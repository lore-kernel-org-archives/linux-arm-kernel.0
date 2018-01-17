From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 14:26:43 +0900
Subject: [PATCH v2 05/13] iommu/rockchip: Fix error handling in init
In-Reply-To: <20180116132540.18939-6-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-6-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5AFHheE+5Dx=0=BeL2W1EYd=Kmcb8fKcCBFRgP8ViuxgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> It's hard to undo bus_set_iommu() in the error path, so move it to the
> end of rk_iommu_probe().

Does this work fine now? I remember we used to need this called in an
early initcall for all the ARM/ARM64 DMA stuff to work.

Best regards,
Tomasz
