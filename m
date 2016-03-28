From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 28 Mar 2016 18:29:32 +0530
Subject: [PATCH V7 5/6] dts: msm8974: Add blsp2_bam dma node
In-Reply-To: <20160326022612.GA3764@hector.attlocal.net>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-6-git-send-email-sricharan@codeaurora.org>
 <CAJAp7Oi33=kraAiU337JdFJZbuKZEVoCtY4FfAv_RgiWVmz+sw@mail.gmail.com>
 <20160326022612.GA3764@hector.attlocal.net>
Message-ID: <000d01d188f1$b150e660$13f2b320$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Mar 25, 2016 at 04:17:30PM -0700, Bjorn Andersson wrote:
> > On Tue, Jan 19, 2016 at 2:02 AM, Sricharan R <sricharan@codeaurora.org>
> wrote:
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
> <snip>
> 
> > > +               blsp2_dma: dma-controller at f9944000 {
> > > +                       compatible = "qcom,bam-v1.4.0";
> > > +                       reg = <0xf9944000 0x19000>;
> > > +                       interrupts = <GIC_SPI 239
IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> > > +                       clock-names = "bam_clk";
> > > +                       #dma-cells = <1>;
> > > +                       qcom,ee = <0>;
> >
> > Without "qcom,bam_ctrl_remote;" and
> > https://patchwork.kernel.org/patch/8639181/ the Xperia Honami board
> > fails to boot with this patch included.
> 
> Ouch.  At least one set of pipes must be used by some other processor and
> TZ has locked down that BLSP.

 Hmm, this was not the case atleast on the apq8074DB board that I tested
this on.

Regards,
 Sricharan
