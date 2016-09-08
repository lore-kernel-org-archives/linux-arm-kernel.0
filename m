From: vincent.siles@provenrun.com (Vincent Siles)
Date: Thu, 8 Sep 2016 11:15:20 +0200
Subject: lsl / lsr possible confusion in v7_flush_dcache_all
Message-ID: <20160908091520.GE14909@vsiles-Desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi !
While reading the v7_flush_dcache_all (arch/arm/mm/cache-v7.S), I
stumbled upon this line:

# r10 is the current cache level
127: add    r2, r10, r10, lsr #1	    @ work out 3x current cache level

If we want r2 to be 3 * r10, we should compute r10 + (r10 << 1), which
is lsl, not lsr.

I check for a recent kernel, the issue seems to still be here:
repo:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
revision:   d71f058617564750261b673ea9b3352382b9cde4

Best regards,
Vincent Siles
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/ea8d9bbd/attachment.sig>
