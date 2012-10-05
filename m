From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Oct 2012 10:13:24 +0900
Subject: [PATCH] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
References: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20121005011324.GB17182@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 01:50:44AM -0700, Stephen Boyd wrote:
> The TWD and SCU configs are selected by default as long as
> SCORPIONMP is false and/or MCT is false. Implementing the logic
> this way certainly saves lines in the Kconfig but it precludes
> those machines which select SCORPIONMP or MCT from participating
> in the single zImage effort because when those machines are
> combined with other SMP capable machines the TWD and SCU are no
> longer selected.
> 
> Push the select out to the machine entries so that we can compile
> these machines together and still select the appropriate configs.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> ---

The shmobile portion of this change seems fine to me.

Acked-by: Simon Horman <horms@verge.net.au>
