From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 16:08:00 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
Message-ID: <20130621160800.64f9965229e5042a7b77e212@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/devices.c between commit 4a1c0e83bb4e ("ARM: OMAP2+:
mbox: remove dependencies with soc.h") from the mailbox tree and commit
82c5cde1c4b0 ("ARM: OMAP2+: Remove omap4 ocp2scp pdata") from the arm-soc
tree.

I fixed it up (removing the include of
linux/platform_data/omap_ocp2scp.h) and can carry the fix as necessary
(no action is required).

That mailbox tree commit looks very similar to commit b8a7cf8e2b15 ("ARM:
OMAP2+: mbox: remove dependencies with soc.h") from the arm-soc tree ...

As an aside, the include of linux/usb/omap_control_usb.h into this file
was removed by commit 608d19380c67 ("ARM: OMAP2+: Remove omap4 pdata for
USB") in the arm-soc tree, but reintroduced by commit 435f4c6d5242
("Merge branch 'next/drivers' into for-next").

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/2d7de735/attachment.sig>
