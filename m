From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 22:15:04 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20121126221504.b5da9b5f938ed84b0693c4a3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/boot/dts/exynos5250-smdk5250.dts between commit 24025f6f5821
("Merge branch 'next/dt-samsung' of
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into
next/dt") from the arm-soc tree and commit 65fc7232786b ("Merge branch
'next/devel-samsung-3' into for-next") from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/exynos5250-smdk5250.dts
index 29f1333,cdeb4f2..0000000
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@@ -208,4 -200,31 +204,27 @@@
  		samsung,mfc-r = <0x43000000 0x800000>;
  		samsung,mfc-l = <0x51000000 0x800000>;
  	};
+ 
 -	hdmi {
 -		hpd-gpio = <&gpx3 7 0xf 1 3>;
 -	};
 -
+ 	i2s_0: i2s at 03830000 {
+ 		gpios = <&gpz 0 2 0 0>, <&gpz 1 2 0 0>, <&gpz 2 2 0 0>,
+ 			<&gpz 3 2 0 0>, <&gpz 4 2 0 0>, <&gpz 5 2 0 0>,
+ 			<&gpz 6 2 0 0>;
+ 	};
+ 
+ 	i2s_1: i2s at 12D60000 {
+ 		status = "disabled";
+ 	};
+ 
+ 	i2s_2: i2s at 12D70000 {
+ 		status = "disabled";
+ 	};
+ 
+ 	dp-controller {
+ 		samsung,color-space = <0>;
+ 		samsung,dynamic-range = <0>;
+ 		samsung,ycbcr-coeff = <0>;
+ 		samsung,color-depth = <1>;
+ 		samsung,link-rate = <0x0a>;
+ 		samsung,lane-count = <4>;
+ 	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/66668faf/attachment.sig>
