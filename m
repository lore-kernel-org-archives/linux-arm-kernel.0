From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 18 Jan 2017 09:55:31 +1100
Subject: linux-next: manual merge of the amlogic tree with the arm-soc tree
Message-ID: <20170118095531.37f33df0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the amlogic tree got a conflict in:

  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi

between commit:

  f7bcd4b6f698 ("ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS")

from the arm-soc tree and commit:

  47961f1353b8 ("ARM64: dts: meson-gx: move the SCPI and SRAM nodes to meson-gx")

from the amlogic tree.

I fixed it up (the latter moved the code modified by the former into
another file, but also incorporated the change from the former) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
