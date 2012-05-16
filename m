From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 May 2012 18:50:45 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120516185045.2f9e9274f373d584fd499eb2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/Kconfig between commit 98fab064d321 ("ARM: Remove unnecessary
selection of TICK_ONESHOT") from the arm tree and commit c24b31147a06
("ARM: mmp: support DT in irq") from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig
index b1a717c,852b12b..0000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -627,6 -616,8 +611,7 @@@ config ARCH_MM
  	select CLKDEV_LOOKUP
  	select GENERIC_CLOCKEVENTS
  	select GPIO_PXA
+ 	select IRQ_DOMAIN
 -	select TICK_ONESHOT
  	select PLAT_PXA
  	select SPARSE_IRQ
  	select GENERIC_ALLOCATOR
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/5c5e389c/attachment.sig>
