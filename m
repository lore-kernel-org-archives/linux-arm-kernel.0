From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2016 18:20:17 +0100
Subject: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
 device-tree parsing
In-Reply-To: <20160323115128.GB17838@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
 <1458669509-7178-7-git-send-email-joro@8bytes.org>
 <56F194BC.3020709@arm.com> <20160323115128.GB17838@8bytes.org>
Message-ID: <20160329172017.GL6745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 12:51:28PM +0100, Joerg Roedel wrote:
> On Tue, Mar 22, 2016 at 06:53:48PM +0000, Robin Murphy wrote:
> > In a stream-matching implementation, a device may quite legitimately
> > own anything up to _all_ of the stream IDs (32768, or 65536 if we
> > ever implement support for the SMMUv2 EXID extension), so this is
> > only a genuine limit for stream indexing (and if anyone ever
> > actually made one of those, I don't think they're running mainline
> > on it).
> 
> Do you mean we might see a lot more than the currently 128 supported
> stream-ids for an smmu?

We might, but this patch is still an improvement for now.

Will
