From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 24 Oct 2014 09:11:10 +0100
Subject: [STLinux Kernel] [PATCH 1/3] media: st-rc: move to using
 reset_control_get_optional
In-Reply-To: <54227CD2.5020705@linaro.org>
References: <1411424501-12673-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411424546-12718-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20140923180255.GA3430@griffinp-ThinkPad-X1-Carbon-2nd>
 <54227CD2.5020705@linaro.org>
Message-ID: <20141024081110.GA22250@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

Sorry seems I never replied to this.

> >>drivers/media/rc/st_rc.c:281:15: warning: assignment makes pointer
> >>from integer without a cast [enabled by default]
> >>   rc_dev->rstc = reset_control_get(dev, NULL);
> >
> >Is managing the reset line actually optional though? I can't test atm as I don't have
> >access to my board, but quite often if the IP's aren't taken out of reset reads / writes
> >to the perhpiheral will hang the SoC.
> >
> Yes and No.
> AFAIK reset line is optional on SOCs like 7108, 7141.
> I think having the driver function without reset might is a value
> add in case we plan to reuse the mainline driver for these SOCs.

Yes that is a good point, for the series: -

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
