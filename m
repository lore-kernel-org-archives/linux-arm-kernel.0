From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Mar 2010 22:01:38 +0100
Subject: [PATCH] CLKDEV: return from clk_find as soon as we get maching clk
In-Reply-To: <20100302203911.GB20675@n2100.arm.linux.org.uk>
References: <1267527954-20270-1-git-send-email-viresh.kumar@st.com>
	<20100302203911.GB20675@n2100.arm.linux.org.uk>
Message-ID: <20100302210138.GB25807@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 02, 2010 at 08:39:11PM +0000, Russell King - ARM Linux wrote:
> On Tue, Mar 02, 2010 at 04:35:54PM +0530, Viresh KUMAR wrote:
> > clk_find function looks for clock with matching dev_id and con_id.
> > We should return from clk_find as soon as we get a clock with matching dev_id
> > and con_id. This can be done by comparing variable "match" with 3.
> 
> This breaks the semantics function.  Please look again at the code you're
> modifying, and ascertain whether you're changing the semantics of it,
> particularly with respect to what happens _in addition_ to returning the
> struct clk.
> 
> Hint: "return p->clk" is insufficient.
I starred a the code a bit, but I don't see the problem here.  match is
always <= 3 so if it is 3 in one iteration best increases to 3 and clk
isn't touched anymore.  The other statements in the loop have no side
effects either.

Apart from that a while back I thought about removing

	if (match == 0)
		continue;

as if match is 0 the next if condition is false.  I don't remember why I
didn't do it.  Maybe I checked the generated code and it made no
difference.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
