From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Aug 2013 18:26:58 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20130827182658.a82bec791f85c98c69751388@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/tegra20-seaboard.dts between commit 30ca2226bea6 ("ARM:
tegra: always enable USB VBUS regulators") from Linus' tree and commit
23f95ef2d951 ("ARM: tegra: use TEGRA_GPIO() in a couple more places")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/tegra20-seaboard.dts
index c824253,f44a9b8..0000000
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@@ -828,9 -829,7 +828,9 @@@
  			regulator-min-microvolt = <5000000>;
  			regulator-max-microvolt = <5000000>;
  			enable-active-high;
- 			gpio = <&gpio 24 0>; /* PD0 */
+ 			gpio = <&gpio TEGRA_GPIO(D, 0) 0>;
 +			regulator-always-on;
 +			regulator-boot-on;
  		};
  	};
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/be054f02/attachment.sig>
