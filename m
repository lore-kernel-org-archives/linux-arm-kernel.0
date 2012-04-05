From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Apr 2012 09:03:24 +0200
Subject: [PATCH] clk: Update comment for clk_round_rate()
In-Reply-To: <4F7D299E.1050307@st.com>
References: <CAOh2x=nTSvOrJa2uB2zTvYh1SUO2YpEpnLcL189itJ=_e+MPog@mail.gmail.com>
 <CAJOA=zOPn0FcwO0McSb8-18h7LiJndRD2nmCCvxUEEm+fakvKg@mail.gmail.com>
 <4F7D299E.1050307@st.com>
Message-ID: <20120405070324.GB27274@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Apr 05, 2012 at 10:41:58AM +0530, Viresh Kumar wrote:
> On 4/4/2012 11:37 PM, Turquette, Mike wrote:
> > The common clk framework doesn't enforce any policy like this, nor do
> > I think it should.  The clk framework is far from complete and I
> > wouldn't be surprised if we see folks who want their rounded rate to
> > represent a minimum value (instead of a maximum as your patch states).
> 
> Ok. Just for example, suppose foo_clk can have following rates:
> 100, 110, 120, 130, 140.
> 
> And we call round_rate with a value of 126.
> 
> Now i can't visualize why would anybody want it to return 130 (above the
> limits requested)? I agree both 100 and 120 can be returned, based on
> your below logic.
It depends on your scenario. E.g. for an UART clock it might be better
to choose 130. Here choosing the frequency is not about a fixed maximum
but to match the sample rate of the device connect to your UART.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
