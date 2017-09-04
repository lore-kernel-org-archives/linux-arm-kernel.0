From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 4 Sep 2017 23:06:21 +0800
Subject: [PATCH v4 2/3] thermal: hisilicon: add thermal sensor driver for
 Hi3660
In-Reply-To: <8fe3ad22-59db-40c6-18db-7b6859f05a95@linaro.org>
References: <e313015d-11d5-91b8-aa64-37e9410cb882@hisilicon.com>
 <1503994666-13954-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1503994666-13954-3-git-send-email-kevin.wangtao@hisilicon.com>
 <77ceb395-57bb-8de7-7b1a-3218baa5d5f3@linaro.org>
 <b884f2ca-86e1-0df3-0cbf-99b13232ee03@hisilicon.com>
 <8fe3ad22-59db-40c6-18db-7b6859f05a95@linaro.org>
Message-ID: <20170904150621.GC24156@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 01:06:39PM +0200, Daniel Lezcano wrote:
> 
> Hi Kevin,
> 
> 
> On 04/09/2017 09:56, Wangtao (Kevin, Kirin) wrote:
> > 
> > 
> > ? 2017/9/1 5:17, Daniel Lezcano ??:
> >>
> >> Hi Kevin,
> >>
> >>
> >> On 29/08/2017 10:17, Tao Wang wrote:
> >>> From: Tao Wang <kevin.wangtao@linaro.org>
> >>>
> >>> This patch adds the support for thermal sensor of Hi3660 SoC.
> >>
> >> for the Hi3660 SoC thermal sensor.
> >>
> >>> this will register sensors for thermal framework and use device
> >>> tree to bind cooling device.
> >>
> >> Is it possible to give a pointer to some documentation or to describe
> >> the hardware?
> > Yes, there used to be on patch V3, I removed it on V4.
> >>
> >> An explanation of the adc min max coef[] range[] conversion would be
> >> nice.
> > OK
> >>
> >> In addition, having the rational behind the average and the max would be
> >> nice. Do we really need both avg and max as virtual sensor?
> > We only need max currently.
> >>
> >>> Signed-off-by: Tao Wang <kevin.wangtao@linaro.org>
> >>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >>> ---
> >>>   drivers/thermal/Kconfig        |  13 +++
> >>>   drivers/thermal/Makefile       |   1 +
> >>>   drivers/thermal/hisi_tsensor.c | 209
> >>> +++++++++++++++++++++++++++++++++++++++++
> >>
> >>
> >> IMO, we don't need a new file, but merge this code with the current
> >> hisi_thermal.c driver. BTW, the hi6220 has also a tsensor which is
> >> different from this one.
> >>
> >> I suggest to base the hi3660 thermal driver on top of the cleanup I sent
> >> for the hi6220.
> > The tsensor of hi3660 is a different one, merging the code with hi6220
> > will need a lot of change.
> 
> Have a look at the hisi_thermal.c at:
> 
> https://git.linaro.org/people/daniel.lezcano/linux.git/tree/drivers/thermal/hisi_thermal.c?h=thermal/hikey-4.14
> 
> after the cleanup I recently sent.
> 
> I'm pretty sure, with a little effort, we can merge both.
> 
> Especially if the virtual things is separated.
> 
> At the end, what do we do ? Read a register.

Just more input at here. I agree currently Hi3660 thermal driver
is quite similiar with Hi6220, before we wrote a dedicated Hi3660
thermal driver due we used mailbox method rather than shared
memory mode.

If we merge two thermal drivers, this means Hi3660 register layout
should be adjusted as same with Hi6220; I am not sure if this is
feasible and need Kevin to confirm for this.

And does this mean we need provide interrupt mode for Hi3660? Or
we can extend the driver to only support pollig mode?

[...]

Thanks,
Leo Yan
