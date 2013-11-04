From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 4 Nov 2013 10:03:00 -0800
Subject: [PATCH 09/11] ARM: msm: Add SMP support for KPSSv2
In-Reply-To: <CACqS6krDt=zDWNXKTu2PvCkMXQbbf-4G2RZtuCt1deU6H2SUxQ@mail.gmail.com>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
 <1383343739-23080-10-git-send-email-sboyd@codeaurora.org>
 <CACqS6krDt=zDWNXKTu2PvCkMXQbbf-4G2RZtuCt1deU6H2SUxQ@mail.gmail.com>
Message-ID: <20131104180300.GM21983@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01, Janakiram Sistla wrote:
> On 1 November 2013 15:08, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > +               err = -ENOMEM;
> > +               goto err_map;
> > +       }
> > +
> > +       l2_saw_base = of_iomap(l2_node, 0);
> > +       if (!l2_saw_base) {
> > +               err = -ENOMEM;
> > +               goto err_l2_map;
> > +       }
> > +
> > +       /* Turn on the BHS, turn off LDO Bypass and power down LDO */
> > +       reg_val =  0x403f0001;
> >
> I think patch looks more nice if this hard coding is defined in terms of
> macros
> 
> > +       writel_relaxed(reg_val, reg + APC_PWR_GATE_CTL);
> > +
> > +       /* complete the above write before the delay */
> > +       mb();
> > +       /* wait for the bhs to settle */
> > +       udelay(1);
> > +
> > +       /* Turn on BHS segments */
> > +       reg_val |= 0x3f << 1;
> >
> same as above
> 

Ok. I'll see what I can do.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
