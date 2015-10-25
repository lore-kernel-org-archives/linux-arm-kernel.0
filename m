From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 25 Oct 2015 08:55:03 +0100
Subject: [PATCH v4 3/3] ARM: dts: rockchip: Add the OTP gpio pinctrl
In-Reply-To: <CAD=FV=WBCD8WsXV2mAGUD6y=BFScbFc9U3XA7jAB-rqOLp4qGA@mail.gmail.com>
References: <1445599528-18825-1-git-send-email-wxt@rock-chips.com>
 <1445599528-18825-4-git-send-email-wxt@rock-chips.com>
 <CAD=FV=WBCD8WsXV2mAGUD6y=BFScbFc9U3XA7jAB-rqOLp4qGA@mail.gmail.com>
Message-ID: <2741625.HAsG2fX6yg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Oktober 2015, 08:25:08 schrieb Doug Anderson:
> On Fri, Oct 23, 2015 at 4:25 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> > Add the "init" anf "sleep" pinctrl as the OTP gpio state.
> > We need the OTP pin is gpio state before resetting the TSADC controller,
> > since the tshut polarity will generate a high signal.
> > 
> > "init" pinctrl property is defined by Doug's Patch[0].
> > 
> > Patch[0]:
> > https://patchwork.kernel.org/patch/7454311/
> > 
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> > Changes in v4: None
> > 
> > Changes in v3:
> >   - Add the "sleep" pinctrl as the gpio state in PATCH[3/3]
> > 
> > Changes in v2:
> >   - Add some commits for more obvious in PATCH[2/2]
> > 
> > Changes in v1:
> >   - As the Doug comments, drop the thermal driver patchs since
> >   
> >     we can with pinctrl changing to work.
> >   
> >   - As the Doug's patch to add the 'init' property.
> >  
> >  arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> I realized that the subject of this patch should probably contain the
> word rk3288, but I presume Heiko would rather add that himself than
> for you to spin this again.  ;)

yep :-) ... no need to respin for such an easy change.
