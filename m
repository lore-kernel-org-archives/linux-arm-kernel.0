From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 01 Apr 2015 15:52:57 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401133908.GI1552@arm.com>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org> <20150401133908.GI1552@arm.com>
Message-ID: <1427896377.22236.8.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-01 at 14:39 +0100, Will Deacon wrote:
> We'd also need to update any page-table code that relies on being called
> one page at a time (i.e. the new io-pgtable stuff we merged for 4.0) so
> that we iterate over the requested range.

Ick. I hadn't noticed we'd entrenched that mistake even harder. It
certainly *wasn't* that hard to fix it...

>  That shouldn't be too difficult (i.e. just inline the iommu_map logic
> into each driver), but it would need some testing.

Good.

> In fact, that would also allow us to nuke the whole TLB on VFIO unmap of
> large ranges. We currently iterate over the range page-by-page, which takes
> ages (minutes) in simulation.

Which is one of the big reasons we lie about page sizes in VT-d.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/9626a9b2/attachment.bin>
