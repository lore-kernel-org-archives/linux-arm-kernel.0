From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Oct 2009 09:56:04 +0200
Subject: [PATCH 7/14] drivers/mmc: Move dereference after NULL test
In-Reply-To: <Pine.LNX.4.64.0910170839430.9213@ask.diku.dk>
References: <Pine.LNX.4.64.0910170839430.9213@ask.diku.dk>
Message-ID: <20091019075604.GB11449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2009 at 08:40:02AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> If the NULL test on mrq is needed, then the derefernce should be after the
> NULL test.
s/derefernce/dereference/
 
> A simplified version of the semantic match that detects this problem is as
> follows (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @match exists@
> expression x, E;
> identifier fld;
> @@
> 
> * x->fld
>   ... when != \(x = E\|&x\)
> * x == NULL
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
Other than that

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
