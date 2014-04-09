From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Apr 2014 12:28:50 -0300
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <20140409145936.GB2334@dragon>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <20140409133422.GA2334@dragon>
 <CAOMZO5CO8ucya8qmVXBo5kgRmuLqKGtpub07o1DuE9yh5LmmPQ@mail.gmail.com>
 <20140409145936.GB2334@dragon>
Message-ID: <CAOMZO5AuwgVijZ_SMYZBOxbq8dVtvUzcQ06TFmmDtiaEQJrYRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Apr 9, 2014 at 11:59 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

> As long as you call clk_register_mux() to register a multiplexer, you
> have to ensure that clk_set_parent() call always works properly on it,
> no matter whether there is one actually calling into it right now.

clk_register_mux() is not called for the ldb_di_sels multiplexer:

**** Clk name is lvds1_sel
********* Calling clk_register_mux
**** Clk name is lvds2_sel
********* Calling clk_register_mux
**** Clk name is step
********* Calling clk_register_mux
**** Clk name is pll1_sw
********* Calling clk_register_mux
**** Clk name is periph_pre
********* Calling clk_register_mux
**** Clk name is periph2_pre
********* Calling clk_register_mux
**** Clk name is periph_clk2_sel
********* Calling clk_register_mux
**** Clk name is periph2_clk2_sel
********* Calling clk_register_mux
**** Clk name is axi_sel
********* Calling clk_register_mux
**** Clk name is esai_sel
********* Calling clk_register_mux
**** Clk name is asrc_sel
********* Calling clk_register_mux
**** Clk name is spdif_sel
********* Calling clk_register_mux
**** Clk name is gpu2d_axi
********* Calling clk_register_mux
**** Clk name is gpu3d_axi
********* Calling clk_register_mux
**** Clk name is gpu2d_core_sel
********* Calling clk_register_mux
**** Clk name is gpu3d_core_sel
********* Calling clk_register_mux
**** Clk name is gpu3d_shader_sel
********* Calling clk_register_mux
**** Clk name is ipu1_sel
********* Calling clk_register_mux
**** Clk name is ipu2_sel
********* Calling clk_register_mux
********* Calling clk_register_mux
********* Calling clk_register_mux
**** Clk name is ipu1_di0_pre_sel
********* Calling clk_register_mux
**** Clk name is ipu1_di1_pre_sel
********* Calling clk_register_mux
**** Clk name is ipu2_di0_pre_sel
********* Calling clk_register_mux
**** Clk name is ipu2_di1_pre_sel
********* Calling clk_register_mux
**** Clk name is ipu1_di0_sel
********* Calling clk_register_mux
**** Clk name is ipu1_di1_sel
********* Calling clk_register_mux
**** Clk name is ipu2_di0_sel
********* Calling clk_register_mux
**** Clk name is ipu2_di1_sel
********* Calling clk_register_mux
**** Clk name is hsi_tx_sel
********* Calling clk_register_mux
**** Clk name is pcie_axi_sel
********* Calling clk_register_mux
**** Clk name is enfc_sel
********* Calling clk_register_mux
**** Clk name is vdo_axi_sel
********* Calling clk_register_mux
**** Clk name is vpu_axi_sel
********* Calling clk_register_mux
**** Clk name is cko1_sel
********* Calling clk_register_mux
**** Clk name is cko2_sel
********* Calling clk_register_mux
**** Clk name is cko
********* Calling clk_register_mux
********* doing ldb clock switch

>
> Furthermore, some re-parenting happens in a way you may not be aware of.
> See commit e366fdd (clk: clk-mux: implement remuxing on set_rate), for
> example.

This commit does not affect us as we pass the CLK_SET_RATE_NO_REPARENT flag.
