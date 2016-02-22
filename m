From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 22 Feb 2016 17:54:57 +0530
Subject: [PATCH V7 4/6] i2c: qup: Add bam dma capabilities
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-5-git-send-email-sricharan@codeaurora.org>
 <20160212183737.GA1520@katana>
Message-ID: <002a01d16d6c$0f790520$2e6b0f60$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> -----Original Message-----
> From: Sricharan [mailto:sricharan at codeaurora.org]
> Sent: Saturday, February 13, 2016 12:29 PM
> To: 'Wolfram Sang'
> Cc: 'devicetree at vger.kernel.org'; 'linux-arm-msm at vger.kernel.org';
> 'agross at codeaurora.org'; 'linux-kernel at vger.kernel.org'; 'linux-
> i2c at vger.kernel.org'; 'iivanov at mm-sol.com'; 'galak at codeaurora.org';
> 'dmaengine at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org';
> 'andy.gross at linaro.org'; 'ntelkar at codeaurora.org';
'architt at codeaurora.org'
> Subject: RE: [PATCH V7 4/6] i2c: qup: Add bam dma capabilities
> 
> Hi Wolfram,
> 
> > -----Original Message-----
> > From: Wolfram Sang [mailto:wsa at the-dreams.de]
> > Sent: Saturday, February 13, 2016 12:08 AM
> > To: Sricharan R
> > Cc: devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> > agross at codeaurora.org; linux-kernel at vger.kernel.org; linux-
> > i2c at vger.kernel.org; iivanov at mm-sol.com; galak at codeaurora.org;
> > dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > andy.gross at linaro.org; ntelkar at codeaurora.org; architt at codeaurora.org
> > Subject: Re: [PATCH V7 4/6] i2c: qup: Add bam dma capabilities
> >
> > On Tue, Jan 19, 2016 at 03:32:44PM +0530, Sricharan R wrote:
> > > QUP cores can be attached to a BAM module, which acts as a dma
> > > engine for the QUP core. When DMA with BAM is enabled, the BAM
> > > consumer
> > pipe
> > > transmitted data is written to the output FIFO and the BAM producer
> > > pipe received data is read from the input FIFO.
> > >
> > > With BAM capabilities, qup-i2c core can transfer more than
> > > 256 bytes, without a 'stop' which is not possible otherwise.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> > > Tested-by: Archit Taneja <architt@codeaurora.org>
> > > Tested-by: Telkar Nagender <ntelkar@codeaurora.org>
> >
> > My code checkers found some issues:
> >
> >     SPARSE
> > drivers/i2c/busses/i2c-qup.c:555:6: warning: symbol 'qup_sg_set_buf'
> > was not declared. Should it be static?
> > drivers/i2c/busses/i2c-qup.c:1243:50: warning: dubious: !x & !y
> >     SMATCH
> > drivers/i2c/busses/i2c-qup.c:165 qup_sg_set_buf warn: unused return: s
> > =
> > sg_next()
> > drivers/i2c/busses/i2c-qup.c:165 qup_sg_set_buf warn: unused return: s
> > =
> > sg_next()
> > drivers/i2c/busses/i2c-qup.c:1243 qup_i2c_xfer_v2() warn: add some
> > parenthesis here?
> >     CPPCHECK
> > drivers/i2c/busses/i2c-qup.c:1243: style: Boolean result is used in
> > bitwise operation. Clarify expression with parentheses.
> >     SPATCH
> > drivers/i2c/busses/i2c-qup.c:1380:2-13: WARNING: Assignment of bool to
> > 0/1
> > drivers/i2c/busses/i2c-qup.c:1481:1-13: WARNING: Assignment of bool to
> 0/1
> >   CC      drivers/i2c/busses/i2c-qup.o
> > drivers/i2c/busses/i2c-qup.c:555:6: warning: no previous prototype for
> > 'qup_sg_set_buf' [-Wmissing-prototypes]  void qup_sg_set_buf(struct
> > scatterlist *sg, void *buf, struct qup_i2c_tag *tg,
> >
> > Can you fix them and resend??
> 
  Really sorry for the delay ,  sent it here [1]

  Also, while testing this series in one of a new platform, found that an
additional 
  Regression and a fix is required on top of this series. So can I send a
separate fix on top of this series ?


[1]   https://patchwork.ozlabs.org/patch/586125/

Regards,
 Sricharan
