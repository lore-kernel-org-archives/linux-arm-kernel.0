From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Mar 2010 19:44:22 +0000
Subject: [PATCH] CLKDEV: return from clk_find as soon as we get maching clk
In-Reply-To: <20100302210138.GB25807@pengutronix.de>
References: <1267527954-20270-1-git-send-email-viresh.kumar@st.com>
	<20100302203911.GB20675@n2100.arm.linux.org.uk>
	<20100302210138.GB25807@pengutronix.de>
Message-ID: <20100303194422.GD4302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 02, 2010 at 10:01:38PM +0100, Uwe Kleine-K?nig wrote:
> I starred a the code a bit, but I don't see the problem here.  match is
> always <= 3 so if it is 3 in one iteration best increases to 3 and clk
> isn't touched anymore.  The other statements in the loop have no side
> effects either.

Yes, you're right - I thought there was some additional code at the end
of the function - was thinking of a previous revision of the code.

I'd still prefer the conditional code to be a 'clk = p->clk; break;'
though, to keep the flow of the code the same.
