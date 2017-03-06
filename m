From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 Mar 2017 09:58:42 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
 <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
 <CAMuHMdXiz5hqW=fm-2H1aNKq_gXD2o0508jD2XjxYUvKoEvHdw@mail.gmail.com>
 <20170304174819.esxhwwbsxzuq3vyc@pengutronix.de>
 <CAMuHMdX8BEnaTtNFAbcvfHwJH=oPUmQ2NB+jfouGyhQpJ_m_4A@mail.gmail.com>
Message-ID: <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

On Mon, Mar 06, 2017 at 09:49:39AM +0100, Geert Uytterhoeven wrote:
> > Given that mctrl-gpio can be useful on legacy platforms, a device could
> > silently run without cts-gpio even there.
> 
> On platforms were CONFIG_GPIOLIB=n, this is not true, so the issue is moot.
> 
> All serial drivers using (optional) mctrl-gpio have this in Kconfig:
> 
>     select SERIAL_MCTRL_GPIO if GPIOLIB
> 
> So they will use mctrl-gpio when GPIOLIB is enabled.
> If GPIOPLIB is disabled, no flow control GPIOs are expected, and the
> driver should not break that case.

So it all boils down to the question: Is GPIOLIB=n enough to assume no
gpio is needed?

I'd say it is not.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
