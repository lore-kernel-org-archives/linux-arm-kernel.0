From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Aug 2015 15:53:46 +0100
Subject: [PATCH 4/5] iommu/msm: Set cacheability attributes without tex
 remap
In-Reply-To: <1439390869-6347-5-git-send-email-sricharan@codeaurora.org>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
 <1439390869-6347-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <20150812145346.GH23540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 03:47:48PM +0100, Sricharan R wrote:
> The cacheablity attributes are set when IOMMU_CACHE property
> is true. So cachebility is set as either noncached (normal)
> or cached (normal WBWA) directly and avoid setting using
> tex remap.

Does this IOMMU support the ARMv7 short descriptor format? If so, would
it work with Yong's patch here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/361615.html

I've not gotten around to reviewing the latest version yet, but having
other IOMMUs consolidate on one set of page table code would be a good
thing.

Will
