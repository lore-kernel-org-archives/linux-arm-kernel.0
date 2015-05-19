From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 16:09:24 +0800
Subject: [PATCH 6/9] ARM: imx: define gpt register offset per device type
In-Reply-To: <2146941.M15MKfMlJf@wuerfel>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
 <1431677507-27420-7-git-send-email-shawnguo@kernel.org>
 <2146941.M15MKfMlJf@wuerfel>
Message-ID: <20150519080924.GX1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 10:34:03AM +0200, Arnd Bergmann wrote:
> On Friday 15 May 2015 16:11:44 shawnguo at kernel.org wrote:
> >  {
> >         switch (imxtm.type) {
> >         case GPT_TYPE_IMX1:
> > +               imxtm.reg_tstat = MX1_2_TSTAT;
> > +               imxtm.reg_tcn = MX1_2_TCN;
> > +               imxtm.reg_tcmp = MX1_2_TCMP;
> >                 imxtm.gpt_setup_tctl = imx1_gpt_setup_tctl;
> >                 clockevent_mxc.set_next_event = mx1_2_set_next_event;
> >                 break;
> >         case GPT_TYPE_IMX21:
> > +               imxtm.reg_tstat = MX1_2_TSTAT;
> > +               imxtm.reg_tcn = MX1_2_TCN;
> > +               imxtm.reg_tcmp = MX1_2_TCMP;
> >                 imxtm.gpt_setup_tctl = imx21_gpt_setup_tctl;
> >                 clockevent_mxc.set_next_event = mx1_2_set_next_event;
> >                 break;
> >         case GPT_TYPE_IMX31:
> > +               imxtm.reg_tstat = V2_TSTAT;
> > +               imxtm.reg_tcn = V2_TCN;
> > +               imxtm.reg_tcmp = V2_TCMP;
> >                 imxtm.gpt_setup_tctl = imx31_gpt_setup_tctl;
> >                 clockevent_mxc.set_next_event = v2_set_next_event;
> >                 break;
> >         case GPT_TYPE_IMX6DL:
> > +               imxtm.reg_tstat = V2_TSTAT;
> > +               imxtm.reg_tcn = V2_TCN;
> > +               imxtm.reg_tcmp = V2_TCMP;
> >                 imxtm.gpt_setup_tctl = imx6dl_gpt_setup_tctl;
> >                 clockevent_mxc.set_next_event = v2_set_next_event;
> >                 break;
> > 
> 
> Hi Shawn,
> 
> I think this could be expressed in a nicer way by defining a structure
> that contains all the settings you derive from the type here, and then
> setting a pointer to that structure based on the compatible string.

Yeah, good suggestion.  Will change.

Shawn
