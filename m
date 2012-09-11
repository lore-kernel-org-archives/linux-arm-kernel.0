From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 09:19:55 +0800
Subject: [PATCH v2 1/4] clk: add of_clk_src_onecell_get() support
In-Reply-To: <20120910173226.20289.88000@nucleus>
References: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
 <1345642590-29905-2-git-send-email-shawn.guo@linaro.org>
 <20120831064125.GA3271@r65073-Latitude-D630>
 <20120906221155.20289.73650@nucleus>
 <20120907002618.GB26709@S2101-09.ap.freescale.net>
 <20120907192444.20289.97042@nucleus>
 <20120910062535.GU26709@S2101-09.ap.freescale.net>
 <20120910173226.20289.88000@nucleus>
Message-ID: <20120911011951.GA13721@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 10:32:26AM -0700, Mike Turquette wrote:
> I didn't realize you were waiting on a stable branch.  It seemed that no
> one used my clk-3.6 stable branch during the last cycle so I got lazy
> and decided not to have a clk-3.7 this time around.  However my current
> clk-next HEAD is stable so creating one is easy enough... done!
> 
Great, thanks.

> Now that I have a clk-3.7 stable branch I'll plan on merging clk-next
> into clk-3.7 periodically as stability dictates.
> 
> Arnd, how does the "arm-soc dependency" thing work?  Do I still issue a
> pull request to Linus for 3.7?
> 
Yes, you will still send clk-3.7 pull request to Linus.  There is
nothing changed on clk tree process.  The only thing you need to ensure
is that clk-3.7 is stable.

When I send imx and mxs dt branches to Arnd and Olof, I will tell them
that the branches get a dependency on clk-3.7.  They will pull your
branch into arm-soc as dependency/clk-3.7 (something like that), and
build arm-soc/next on top of dependency/clk-3.7 and imx/mxs dt branches.
During merge window, none of the dependency/* branches will be sent by
Arnd and Olof.  Instead, they will keep an eye on whether those branches
have been merged to Linus' tree, and will only send imx/mxs dt branches
to Linus after clk-3.7 gets merged for this example.

-- 
Regards,
Shawn
