From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 23:50:11 +0000
Subject: [PATCH] ARM: MM: Add ARM_L1_CACHE_SHIFT_BY6 for handle inside
	each ARCH Kconfig
In-Reply-To: <1264635251-29987-1-git-send-email-kgene.kim@samsung.com>
References: <1264635251-29987-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100127235011.GH29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 08:34:11AM +0900, Kukjin Kim wrote:
> This patch adds ARM_L1_CACHE_SHIFT_BY6 into arch/arm/Kconfig. Basically,
> ARM L1 cache line size is 32Bytes. Therefore, whenever new ARCH which
> has 64Bytes L1 cache line size is added, have to set ARM_L1_CACHE_SHIFT
> to 6. That is, have to add/modify arch/arm/mm/Kconfig.
> This patch is for handle it in each ARCH Kconfig.

(a) please don't introduce new stuff which doesn't appear to be used;
    if you decide not to send the patch which uses whatever you've
    added, it goes unnoticed and just adds unnecessary bloat to the
    kernel.

(b) please drop the 'BY' from the name.

(c) it would make sense to convert the existing users (which would
    sort point a.)
