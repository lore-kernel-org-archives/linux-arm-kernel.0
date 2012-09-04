From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Sep 2012 16:06:26 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm-current tree
Message-ID: <20120904160626.f1dcb67ebbb145053c49da8c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mm/mmu.c between commit a849088aa155 ("ARM: Fix ioremap() of
address zero") from the arm-current tree and commit c2794437091a ("ARM:
Add fixed PCI i/o mapping") from the arm-soc tree.

I am not sure how to fix this, so I have used the arm-current version of
the change to pmd_empty_section_gap() since that changed the vm->flags.
It may be that just changing the vm->flags value in vm_reserve_area_early()
would be ok?
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120904/fec57bd4/attachment.sig>
