From: julia@diku.dk (Julia Lawall)
Date: Sun, 20 Mar 2011 18:56:59 +0100 (CET)
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <20110316083326.GF13316@pengutronix.de>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What is the degree of interest in having gpio_request_one be used?  Right 
now, it is very little used.  But there seem to be over 900 places where 
it could be used.

One advantage of gpio_request_one is that it manages error handling.  
However a number of current calls to gpio_request and 
gpio_direction_input/output don't save or test the return value.  Are 
there cases where these operations cannot fail?

julia
