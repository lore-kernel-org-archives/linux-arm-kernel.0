From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Feb 2015 23:06:11 +0100
Subject: [PATCH 4/7] serial: imx: drop support for IRDA
In-Reply-To: <CAOMZO5AfE_tikox7d49=9ZtSD8R0_mGuuOQWZEg+E3rTqL4LSA@mail.gmail.com>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AfE_tikox7d49=9ZtSD8R0_mGuuOQWZEg+E3rTqL4LSA@mail.gmail.com>
Message-ID: <20150218220611.GN19388@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Fabio,

On Wed, Feb 18, 2015 at 07:16:39PM -0200, Fabio Estevam wrote:
> On Wed, Feb 18, 2015 at 6:41 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Support for IRDA was added in 2009 in commit v2.6.31-rc1~399^2~2. There
> > are no in-tree users.
> 
> 'fsl,irda-mode' is still documented at
> Documentation/devicetree/bindings/serial/fsl-imx-uart.txt .
I wondered if I should remove it but decided to not do that for
compatibility reasons. The driver not supporting it any more is a
different thing.

> Is the irda support broken?
It is (was) inconsitent and did some things in strange ways. For example
instead of disabling RC it only disabled the corresponding irqs and
flushed the fifo before reenabling. I couldn't test it because I don't
have such hardware though.

> Maybe there are people using it in out-of-tree dts files?
I expect them to cry at some point if they exist. In this case I'm
willing to help them to reinstanciate support for it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
