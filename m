From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 04 Jul 2018 10:07:08 +0200
Subject: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
In-Reply-To: <ad673997-927e-76f4-23a4-bcf28f269968@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-4-yixun.lan@amlogic.com>
 <CAFBinCCFQr+_k7bkda0a3wVQdyG8DzEyim6v_OBikUifCxyVXg@mail.gmail.com>
 <ad673997-927e-76f4-23a4-bcf28f269968@amlogic.com>
Message-ID: <1530691628.2900.216.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-04 at 15:17 +0800, Yixun Lan wrote:
> > you are describing the mux and the divider here
> > however, meson-gx-mmc.c has a few more clock related bits:
> > - CLK_CORE_PHASE_MASK
> > - CLK_TX_PHASE_MASK
> > - CLK_RX_PHASE_MASK
> > - CLK_V2_TX_DELAY_MASK / CLK_V3_TX_DELAY_MASK
> > - CLK_V2_RX_DELAY_MASK / CLK_V3_RX_DELAY_MASK
> > - CLK_V2_ALWAYS_ON / CLK_V3_ALWAYS_ON
> > 
> > are these used for the MMC clock or are some of these routed to the
> > NAND pins as well?
> 
> There clocks are not used in NAND driver..
> 
> I understand your concern here, if there clocks are also routed to NAND
> pins, then we also need to implement them here
> actually, to answer your question, I need to query the ASIC team..

Even if the NAND driver does not need to change the phases, it might need to
make sure these phases are reset on init. It would not hurt to handle these
phases in your clock controller.
