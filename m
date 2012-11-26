From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 21:06:04 +1100
Subject: linux-next: manual merge of the arm-soc tree with the thermal tree
Message-ID: <20121126210604.e8ae2a872b9a3d0e60609740@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/snowball.dts between commit dc1956b5f84d ("Thermal: Add
ST-Ericsson DB8500 thermal properties and platform data") from the
thermal tree and commit 809efa565a83 ("ARM: ux500: Move regulator-name
properties out to board DTS files") from the arm-soc tree.

I fixed it up (I think - see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/snowball.dts
index c6f85f0,9e02a91..0000000
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@@ -211,8 -184,136 +211,140 @@@
  			};
  		};
  
 +		cpufreq-cooling {
 +			status = "okay";
 +		};
++
+ 		prcmu at 80157000 {
+ 			db8500-prcmu-regulators {
+ 				db8500_vape_reg: db8500_vape {
+ 					regulator-name = "db8500-vape";
+ 				};
+ 
+ 				db8500_varm_reg: db8500_varm {
+ 					regulator-name = "db8500-varm";
+ 				};
+ 
+ 				db8500_vmodem_reg: db8500_vmodem {
+ 					regulator-name = "db8500-vmodem";
+ 				};
+ 
+ 				db8500_vpll_reg: db8500_vpll {
+ 					regulator-name = "db8500-vpll";
+ 				};
+ 
+ 				db8500_vsmps1_reg: db8500_vsmps1 {
+ 					regulator-name = "db8500-vsmps1";
+ 				};
+ 
+ 				db8500_vsmps2_reg: db8500_vsmps2 {
+ 					regulator-name = "db8500-vsmps2";
+ 				};
+ 
+ 				db8500_vsmps3_reg: db8500_vsmps3 {
+ 					regulator-name = "db8500-vsmps3";
+ 				};
+ 
+ 				db8500_vrf1_reg: db8500_vrf1 {
+ 					regulator-name = "db8500-vrf1";
+ 				};
+ 
+ 				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
+ 					regulator-name = "db8500-sva-mmdsp";
+ 				};
+ 
+ 				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
+ 					regulator-name = "db8500-sva-mmdsp-ret";
+ 				};
+ 
+ 				db8500_sva_pipe_reg: db8500_sva_pipe {
+ 					regulator-name = "db8500_sva_pipe";
+ 				};
+ 
+ 				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
+ 					regulator-name = "db8500_sia_mmdsp";
+ 				};
+ 
+ 				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
+ 					regulator-name = "db8500-sia-mmdsp-ret";
+ 				};
+ 
+ 				db8500_sia_pipe_reg: db8500_sia_pipe {
+ 					regulator-name = "db8500-sia-pipe";
+ 				};
+ 
+ 				db8500_sga_reg: db8500_sga {
+ 					regulator-name = "db8500-sga";
+ 				};
+ 
+ 				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
+ 					regulator-name = "db8500-b2r2-mcde";
+ 				};
+ 
+ 				db8500_esram12_reg: db8500_esram12 {
+ 					regulator-name = "db8500-esram12";
+ 				};
+ 
+ 				db8500_esram12_ret_reg: db8500_esram12_ret {
+ 					regulator-name = "db8500-esram12-ret";
+ 				};
+ 
+ 				db8500_esram34_reg: db8500_esram34 {
+ 					regulator-name = "db8500-esram34";
+ 				};
+ 
+ 				db8500_esram34_ret_reg: db8500_esram34_ret {
+ 					regulator-name = "db8500-esram34-ret";
+ 				};
+ 			};
+ 
+ 			ab8500 at 5 {
+ 				ab8500-regulators {
+ 					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
+ 						regulator-name = "V-DISPLAY";
+ 					};
+ 
+ 					ab8500_ldo_aux2_reg: ab8500_ldo_aux2 {
+ 						regulator-name = "V-eMMC1";
+ 					};
+ 
+ 					ab8500_ldo_aux3_reg: ab8500_ldo_aux3 {
+ 						regulator-name = "V-MMC-SD";
+ 					};
+ 
+ 					ab8500_ldo_initcore_reg: ab8500_ldo_initcore {
+ 						regulator-name = "V-INTCORE";
+ 					};
+ 
+ 					ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
+ 						regulator-name = "V-TVOUT";
+ 					};
+ 
+ 					ab8500_ldo_usb_reg: ab8500_ldo_usb {
+ 						regulator-name = "dummy";
+ 					};
+ 
+ 					ab8500_ldo_audio_reg: ab8500_ldo_audio {
+ 						regulator-name = "V-AUD";
+ 					};
+ 
+ 					ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
+ 						regulator-name = "V-AMIC1";
+ 					};
+ 
+ 					ab8500_ldo_amamic2_reg: ab8500_ldo_amamic2 {
+ 						regulator-name = "V-AMIC2";
+ 					};
+ 
+ 					ab8500_ldo_dmic_reg: ab8500_ldo_dmic {
+ 						regulator-name = "V-DMIC";
+ 					};
+ 
+ 					ab8500_ldo_ana_reg: ab8500_ldo_ana {
+ 						regulator-name = "V-CSI/DSI";
+ 					};
+ 				};
+ 			};
+ 		};
  	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/339a0f7f/attachment.sig>
