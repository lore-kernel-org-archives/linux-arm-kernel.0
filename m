From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Jan 2017 18:21:25 +0100
Subject: [PATCH 06/14] mmc: dw_mmc: simplify optional reset handling
In-Reply-To: <CAPDyKFrDKW4DCzqeX6dim=3MmcU77DhDSbXyw7pwPt=OLkUpHA@mail.gmail.com>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-6-p.zabel@pengutronix.de>
 <CAPDyKFrDKW4DCzqeX6dim=3MmcU77DhDSbXyw7pwPt=OLkUpHA@mail.gmail.com>
Message-ID: <1485883285.29355.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-31 at 12:52 +0100, Ulf Hansson wrote:
> On 30 January 2017 at 12:41, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > As of commit bb475230b8e5 ("reset: make optional functions really
> > optional"), the reset framework API calls use NULL pointers to describe
> > optional, non-present reset controls.
> >
> > This allows to return errors from devm_reset_control_get_optional and to
> > call reset_control_(de)assert unconditionally.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Guodong Xu <guodong.xu@linaro.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Philipp, I have looked at patch 6,7,8 in this series - they look good to me.

Thank you.

> However, could you please re-post to linux-mmc and make sure to
> include the proper driver maintainers for each change. For example,
> Jaehoon Chung maintains dw_mmc.

My mistake, I tried to be clever and include the people responsible for
the reset code, manually, and managed to forget a few maintainers
instead.

> Moreover, I assume you want me to pick the mmc changes or is there is
> dependency to another tree here?

arm-soc, currently. I think the easiest will be if I just resend this
after bb475230b8e5 is merged into mainline.

regards
Philipp
