From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 Jan 2016 12:26:45 +0100
Subject: [PATCH v1] iommu/rockchip: reconstruct to support multi slaves
In-Reply-To: <1453186980-21055-1-git-send-email-zhengsq@rock-chips.com>
References: <1453186980-21055-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20160129112645.GC4204@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 03:03:00PM +0800, Shunqian Zheng wrote:
> From: ZhengShunQian <zhengsq@rock-chips.com>
> 
> There are some IPs, such as video encoder/decoder, contains 2 slave iommus,
> one for reading and the other for writing. They share the same irq and
> clock with master.
> 
> This patch reconstructs to support this case by making them share the same
> Page Directory, Page Tables and even the register operations.
> That means every instruction to the reading MMU registers would be
> duplicated to the writing MMU and vice versa.
> 
> Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 214 ++++++++++++++++++++++++++---------------
>  1 file changed, 135 insertions(+), 79 deletions(-)

Applied, thanks.
