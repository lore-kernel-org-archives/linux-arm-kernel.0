From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 23 Mar 2016 12:51:28 +0100
Subject: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
 device-tree parsing
In-Reply-To: <56F194BC.3020709@arm.com>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
 <1458669509-7178-7-git-send-email-joro@8bytes.org>
 <56F194BC.3020709@arm.com>
Message-ID: <20160323115128.GB17838@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Mar 22, 2016 at 06:53:48PM +0000, Robin Murphy wrote:
> In a stream-matching implementation, a device may quite legitimately
> own anything up to _all_ of the stream IDs (32768, or 65536 if we
> ever implement support for the SMMUv2 EXID extension), so this is
> only a genuine limit for stream indexing (and if anyone ever
> actually made one of those, I don't think they're running mainline
> on it).

Do you mean we might see a lot more than the currently 128 supported
stream-ids for an smmu?

> Alternatively, how straightforward is it to change the DT on your
> machine? I'll be getting a v2 of [1] out in a couple of weeks (after
> imminent holidays), which already gets rid of MAX_MASTER_STREAMIDS
> altogether, and might also have grown proper SMR support by then.

Hmm, I don't know how to change the DT of this Seattle machine. I think
it is provided by the ACPI BIOS. At least it boots with grub2 and not
u-boot and there is no DT in /boot.


	Joerg
