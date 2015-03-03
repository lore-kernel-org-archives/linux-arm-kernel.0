From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 3 Mar 2015 14:36:59 +0100
Subject: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
In-Reply-To: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
Message-ID: <20150303133659.GD10502@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 08:19:21PM +0900, Tomasz Figa wrote:
> Even though the code uses the dt_lock spin lock to serialize mapping
> operation from different threads, it does not protect from IOMMU
> accesses that might be already taking place and thus altering state
> of the IOTLB. This means that current mapping code which first zaps
> the page table and only then updates it with new mapping which is
> prone to mentioned race.

Could you elabortate a bit on the race and why it is sufficient to zap
only the first and the last iova? From the description and the comments
in the patch this is not clear to me.


	Joerg
