From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Dec 2013 14:25:24 +0000
Subject: [PATCH 2/2] arm64: dts: Reduce size of virtio block device for
 foundation model
In-Reply-To: <1387543964-15057-2-git-send-email-broonie@kernel.org>
References: <1387543964-15057-1-git-send-email-broonie@kernel.org>
 <1387543964-15057-2-git-send-email-broonie@kernel.org>
Message-ID: <20131220142524.GB11954@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 12:52:44PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Will Deacon observed that kvmtool uses a size of 0x200 for virtio
> block memory region and that the virtio block spec only uses 31 bytes in
> the device specific region at 0x100 so reduce the region to a less
> wasteful 0x200.

What do we waste by keeping it at 4K? That's ioremap'ed, so we use a
full page anyway.

-- 
Catalin
