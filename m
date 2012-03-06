From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 6 Mar 2012 17:21:30 +1100
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc tree
Message-ID: <20120306172130.f5b7aae24600cbbbaf7e84e9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-imx/mm-imx3.c between commit 3bc34a614335 ("ARM: imx:
convert audmux to a platform driver") from the sound-asoc tree and commit
bb07d7511e08 ("ARM: mx3: Setup AIPS registers") from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/mm-imx3.c
index 9c9b7f9,17963e0..0000000
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@@ -177,8 -175,9 +179,12 @@@ void __init imx31_soc_init(void
  	}
  
  	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
+ 
+ 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
+ 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
++
 +	platform_device_register_simple("imx31-audmux", 0, imx31_audmux_res,
 +					ARRAY_SIZE(imx31_audmux_res));
  }
  #endif /* ifdef CONFIG_SOC_IMX31 */
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/b39c2029/attachment.sig>
