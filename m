From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 11:03:03 -0700
Subject: [PATCH v2] clk: imx: Set CLK_SET_RATE_GATE for gate and divider
 clocks
In-Reply-To: <20180418023214.GN25429@dragon>
References: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
 <1523455409-7771-1-git-send-email-abel.vesa@nxp.com>
 <20180418023214.GN25429@dragon>
Message-ID: <152787618372.144038.1631053597248122575@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2018-04-17 19:32:16)
> On Wed, Apr 11, 2018 at 05:03:29PM +0300, Abel Vesa wrote:
> > From: Shawn Guo <shawnguo@kernel.org>
> > 
> > Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
> > client drivers usually make clk_set_rate() call, so that the call will fail
> > when clock is still on instead of standing the risk of running into glitch
> > issue. Rate cannot be changed when the clock is enabled due to the glitchy
> > multiplexers.
> > 
> > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > [initial patch from imx internal repo]
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > [carried over from 3.14 and also applied the flag to newer functions]
> > ---
> > 
> > Changes since v1:
> >  - changed ownership as per initial patch
> 
> IIRC, the patch was created on vendor kernel long time ago to work
> around a specific glitchy multiplexer issue seen on particular SoC.
> I'm not sure it's good for the upstream kernel today.
> 

I'm taking this as a Nak. Resend or restart this discussion if you want
me to apply this.
