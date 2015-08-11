From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 15:34:09 -0700
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <20150730100908.GI2564@lukather>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <554BD33D.7050907@codeaurora.org> <20150508100247.GQ11057@lukather>
 <4099394.C7vEjTFs8V@diego> <20150730100908.GI2564@lukather>
Message-ID: <20150811223409.GN2839@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30, Maxime Ripard wrote:
> On Mon, Jul 27, 2015 at 10:57:33AM +0200, Heiko St?bner wrote:
> > 
> > did this lead anywhere meanwhile.
> > 
> > Last I remember the change to orphan handling made sunxi fail, but
> > I'm still hoping to get this usable at some point :-)
> 
> To be honest, I don't know what the current status is. I haven't get
> any news since that mail.
> 
> I started to move a significant portion of our clocks to
> CLK_OF_DECLARE, but not all of them are (which probably make the
> situation worse for the time being).
> 

Sorry, I think we're still waiting for the critical clocks stuff
to settle down so that Sunxi can use that instead of calling
clk_prepare_enable() in init code. For now, I've put the first
patch of the two into clk-next so that we can have proper orphan
tracking. Hopefully we resolve critical clocks soon so that we
can merge the defer part.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
