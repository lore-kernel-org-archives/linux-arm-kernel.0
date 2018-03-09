From: ping.bai@nxp.com (Jacky Bai)
Date: Fri, 9 Mar 2018 05:10:14 +0000
Subject: [PATCH v4 3/3] driver: clocksource: add gpt timer for imx6sll
In-Reply-To: <20180309012934.GC3217@dragon>
References: <1520501697-22202-1-git-send-email-ping.bai@nxp.com>
 <1520501697-22202-3-git-send-email-ping.bai@nxp.com>
 <20180309012934.GC3217@dragon>
Message-ID: <HE1PR04MB311397D136FB9E6FD6209B4987DE0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v4 3/3] driver: clocksource: add gpt timer for imx6sll
> 
> On Thu, Mar 08, 2018 at 05:34:57PM +0800, Bai Ping wrote:
> > Add gpt timer support for i.MX6SLL.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> The patch should be sent to clocksource maintainer.
> 
> > ---
> > change v1->v2:
> >  - no
> > change v2->v3:
> >  - no
> > change v3->v4:
> >  - no
> > ---
> >  drivers/clocksource/timer-imx-gpt.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clocksource/timer-imx-gpt.c
> > b/drivers/clocksource/timer-imx-gpt.c
> > index 6ec6d79..57b7eab 100644
> > --- a/drivers/clocksource/timer-imx-gpt.c
> > +++ b/drivers/clocksource/timer-imx-gpt.c
> > @@ -557,3 +557,4 @@ static int __init imx6dl_timer_init_dt(struct
> > device_node *np)  TIMER_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt",
> > imx6dl_timer_init_dt);  TIMER_OF_DECLARE(imx6sl_timer,
> > "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
> > TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt",
> > imx6dl_timer_init_dt);
> > +TIMER_OF_DECLARE(imx6sll_timer, "fsl,imx6sll-gpt",
> > +imx6dl_timer_init_dt);
> 
> I'm wondering if we can save this change by letting the compatible of imx6sll-gpt
> fall on "fsl,imx6dl-gpt" in DT.
> 

Sure, this patch can be dropped. I will update the dts compatible string accordingly.

Jacky

> Shawn
