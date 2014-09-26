From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 26 Sep 2014 11:55:39 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20140926115539.6873630b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

Error: arch/arm/boot/dts/hisi-x5hd2.dtsi:374.22-23 syntax error
FATAL ERROR: Unable to parse input tree

There are a series of new commits to this file today and I have no idea
which one caused the problem.

I reverted:

610bd8722ef4	"ARM: dts: hix5hd2: add wdg node"
6868feb6dd97	"ARM: dts: hix5hd2: add gpio node"
420a2d55f046	"ARM: dts: hix5hd2: add sata node"
f16c7fb2f3ff	"ARM: dts: hix5hd2: add usb node"
b196e1ca400d	"ARM: dts: hix5hd2: add mmc node"
de8b6054780e	"ARM: dts: hix5hd2: add gmac node"

which fixed the build problem.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/3b473feb/attachment.sig>
