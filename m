From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 25 Jan 2010 17:01:40 +0200
Subject: [PATCH 3/4] mx25: fix time accounting
In-Reply-To: <19293.31818.225869.565911@ipc1.ka-ro>
References: <20100125105439.GE6724@jasper.tkos.co.il>
	<fe6ca311cc749bf23a8f99e27ad460ff0aafa69a.1264416923.git.baruch@tkos.co.il>
	<19293.31818.225869.565911@ipc1.ka-ro>
Message-ID: <20100125150140.GG6724@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Mon, Jan 25, 2010 at 12:11:06PM +0100, Lothar Wa?mann wrote:
> Baruch Siach writes:

[snip]

> > -DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL, NULL);
> > +DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
> >  DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
> >  DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
> >  DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
> >
> IMO all those clocks should have the appropriate parent clocks, which
> would fix the problem with the GPT clock rate without the need for a
> special get_rate_*() functions and woould also make sure the parent
> clock is enabled when the child clock is being enabled:
> |DEFINE_CLOCK(gpt1_clk1,   0, CCM_CGCR1, 19, NULL, NULL, &ipg_clk);
> |DEFINE_CLOCK(gpt1_clk,    0, CCM_CGCR0,  5, NULL, &gpt1_clk1, &per_clk5);

The i.MX25 clock configuration infrastructure clearly needs more work. This 
patch only fixes a critical bug while doing the minimal possible change.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
