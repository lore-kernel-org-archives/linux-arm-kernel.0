From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 25 Apr 2016 10:04:15 +0100
Subject: [PATCH 03/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A57989B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-4-git-send-email-peter.griffin@linaro.org>
 <C246CAC1457055469EF09E3A7AC4E11A4A57989B@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160425090415.GB20365@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2016, Appana Durga Kedareswara Rao wrote:
> > -----Original Message-----
> > From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> > owner at vger.kernel.org] On Behalf Of Peter Griffin
> > Sent: Thursday, April 21, 2016 4:34 PM
> > To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > srinivas.kandagatla at gmail.com; maxime.coquelin at st.com;
> > patrice.chotard at st.com; vinod.koul at intel.com
> > Cc: peter.griffin at linaro.org; lee.jones at linaro.org;
> > dmaengine at vger.kernel.org; devicetree at vger.kernel.org; arnd at arndb.de;
> > broonie at kernel.org; ludovic.barre at st.com
> > Subject: [PATCH 03/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
> > engine driver support

What is this text?  If you wish to contribute to upstream mailing
lists, please fix your email client.  Also, please read:

  Documentation/email-clients.txt

> > This patch adds support for the Flexible Direct Memory Access (FDMA) core
> > driver. The FDMA is a slim core CPU with a dedicated firmware.
> > It is a general purpose DMA controller capable of supporting 16
> > independent DMA channels. Data moves maybe from memory to memory
> > or between memory and paced latency critical real time targets and it
> > is found on al STi based chipsets.
> > 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/dma/Kconfig   |  12 +
> >  drivers/dma/Makefile  |   1 +
> >  drivers/dma/st_fdma.c | 967
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 980 insertions(+)
> >  create mode 100644 drivers/dma/st_fdma.c

[...]
> > +static int st_fdma_clk_enable(struct st_fdma_dev *fdev)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < CLK_MAX_NUM; i++) {
> > +		ret = clk_prepare_enable(fdev->clks[i]);
> > +		if (ret < 0)
> 
> You should disable and unprepared the other clocks...

Replying to a 1000 line email and not snipping (especially for a one
single-line comment), it considered bad etiquette.  Please remove all
unrelated text in future.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
