From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 9 Feb 2015 20:22:12 +0900
Subject: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
In-Reply-To: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
References: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
Message-ID: <CAAFQd5AhsuX04gV3mwb7krZmrOvwTv3FsPJ34x84wng50v5_eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 9, 2015 at 8:19 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> Even though the code uses the dt_lock spin lock to serialize mapping
> operation from different threads, it does not protect from IOMMU
> accesses that might be already taking place and thus altering state
> of the IOTLB. This means that current mapping code which first zaps
> the page table and only then updates it with new mapping which is
> prone to mentioned race.

Oops, forgot to remove the "CHROMIUM" tag. Is that something that
could be fixed when applying (if the patch is otherwise okay) or
should I resend?

Best regards,
Tomasz
