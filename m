From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 01 Apr 2015 16:28:10 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401140512.GJ1552@arm.com>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org> <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org> <20150401140512.GJ1552@arm.com>
Message-ID: <1427898490.22236.10.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-01 at 15:05 +0100, Will Deacon wrote:
> That just leaves the case where the caller tries to map something
> smaller than a page. Do we want to return the amount mapped in
> iommu_map?

Perhaps we should just expose the *minimum* page size? Although for the
IOMMU API I thought that was always assumed to be the same as PAGE_SIZE,
and for the DMA API it doesn't matter much because you're *given* the
IOVA, and you just know that it's mapped *enough*.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/378fd17a/attachment-0001.bin>
