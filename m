From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Sep 2015 11:50:29 +0200
Subject: [PATCH v2 1/8] clk: imx: add common logic to detect early UART
 usage
In-Reply-To: <1441617354.28391.5.camel@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
 <1441382419-4343-2-git-send-email-l.stach@pengutronix.de>
 <20150907090603.GU9999@pengutronix.de>
 <1441617354.28391.5.camel@pengutronix.de>
Message-ID: <20150907095029.GB9999@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Lucas,

On Mon, Sep 07, 2015 at 11:15:54AM +0200, Lucas Stach wrote:
> Am Montag, den 07.09.2015, 11:06 +0200 schrieb Uwe Kleine-K?nig:
> > I wonder why you need an array of pointers to pointers of clocks. Isn't
> > one indirection less possible and more easy?
> > 
> No, this is not easily possible if we want to use the auto-discarding of
> the clocks array and a simple static initialization. The clock pointers
> are only set up after the clock drivers probe routine has run, so if I
> want to point to the actual clocks I would need to dynamically populate
> the array and either dynamically allocate it, or would need to pre-size
> the static array.
Ah right. An alternative would be to just store the indices, but I don't
think this is nicer because then you additionally need a reference to
the clk array. You don't happen to have this anyhow, do you?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
