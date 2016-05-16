From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 16 May 2016 10:02:39 +0200
Subject: [PATCH 02/16] clk: sunxi-ng: Add common infrastructure
In-Reply-To: <20160515183122.GA27618@lukather>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67XWt6tjG_xXWgGatTaiN5uYQb2_Q6bgixMDUkHfVHLHg@mail.gmail.com>
 <20160515183122.GA27618@lukather>
Message-ID: <20160516100239.a93a238b0d458b38a3689a95@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 May 2016 20:31:22 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > +void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
> > > +{
> > > +       u32 reg;
> > > +
> > > +       if (!(common->features & CCU_FEATURE_LOCK))
> > > +               return;
> > > +
> > > +       WARN_ON(readl_relaxed_poll_timeout(common->base + common->reg, reg,
> > > +                                          !(reg & lock), 0, 500));
> > 
> >                                     no delay between reads? ^
> 
> Yes, I intended it to be a simple busy waiting loop since I don't
> expect it to be very long. Do yu have any more data on how much time
> it usually takes?

I have a Soc in which the rate of the audio clock is stable after a
good second.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
