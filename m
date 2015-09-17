From: davem@davemloft.net (David Miller)
Date: Thu, 17 Sep 2015 11:38:06 -0700 (PDT)
Subject: [PATCH] iommu-common: only compile lib/iommu_common.c for Sparc64
In-Reply-To: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
References: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150917.113806.1491126940106627619.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>
Date: Thu, 17 Sep 2015 09:40:27 +0100

> It seems the types used in this file are not really correct, but a
> fix isn't trivial.  So for the time being restrict this code to be
> compiled only when we actually need it.  Compile tested on Sparc,
> Sparc64, PPC64, ARM, ARM64, x86.

The whole reason this code gets compiled unconditionally is to
ensure it's portability so that other platforms can use it at
some point.

So I would ask that, instead of sweeping it under the rug, you
help work on fixing the problem you've uncovered.

Thanks.
