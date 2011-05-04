From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 May 2011 08:40:15 +0200
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <4DBF4AA9.7010309@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>
	<4DBE2064.2060303@gmail.com> <1304307632.2686.33.camel@pororo>
	<4DBEDC12.4090203@gmail.com>
	<20110502223636.GB28001@n2100.arm.linux.org.uk>
	<4DBF4AA9.7010309@codeaurora.org>
Message-ID: <20110504064015.GZ14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 05:22:01PM -0700, Saravana Kannan wrote:
> >This does bring us to an interesting question though: should clk_set_rate()
> >succeed or fail with a NULL clk?  There is no clock to control, so my
> >feeling is that it should fail, just like clk_get_rate() should return
> >zero because the rate is meaningless.  There is no rate to get and no
> >rate to set.
> 
> I think having NULL clocks return success on set_rate() would be
> more useful. The most common use case for NULL clocks is when a
> clocks is present in some soc/arch/mach but is not present in
> another. Instead of having the consumers having an "if" around every
> clk_* calls on that clk, they would get a NULL clk. If NULL clk
> starts failing for clk_set_rate(), I think the point of a NULL clk
> will get defeated.
