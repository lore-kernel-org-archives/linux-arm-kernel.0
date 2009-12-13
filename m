From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Dec 2009 20:56:07 +0100
Subject: [PATCH 1/4] mfd: mc13783: Take care of semantic inversion
	between read and write value of two bits in POWER_MISCELLANEUS
	register.
In-Reply-To: <1260636523.2054.28.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
Message-ID: <20091213195606.GA14024@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2009 at 05:48:43PM +0100, Alberto Panizzo wrote:
> MC13783_REGCTRL_PWGTnSPIEN controls the states of the corresponding
> PWGTn_DRV output.
> Reading 1 on the corresponding bit mean that the output is enabled
> Writing 1 on the corresponding bit disable that output!
> 
> So, if not asked directly to modify those bits, write the inverted
> value.
Hmm, I'm not sure this completely right.  The Spec has:

        Bit PWGTxSPIEN | Pin PWGTxEN | PWGTxDRV |  Read Back
          0 = default  |             |          | PWGTxSPIEN
        ---------------+-------------+----------+------------
              1        |      x      |   Low    |     0
              0        |      0      |   High   |     1
              0        |      1      |   Low    |     0

So it looks a bit harder than just inverting the read bit.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
