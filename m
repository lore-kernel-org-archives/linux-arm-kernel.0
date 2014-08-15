From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 13:52:08 +0100
Subject: [PATCH] mmc: sdhci-pxav3: set_uhs_signaling is initialized twice
 differently
In-Reply-To: <20140815094707.GW30401@n2100.arm.linux.org.uk>
References: <1408093958-26058-1-git-send-email-peter.griffin@linaro.org>
 <20140815094707.GW30401@n2100.arm.linux.org.uk>
Message-ID: <20140815125208.GA19855@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> > This happened in
> > commit 96d7b78cfc2f ("mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function")
> > commit a702c8abb2a9 ("mmc: host: split up sdhci-pxa, create sdhci-pxav3.c")'
> 
> This is exactly why named initialisers should always follow the
> declaration order in the structure definition.
> 
> It also helps avoid git merge to properly resolve two additions of
> the same member (possibly with a conflict) rather than just adding
> both.

Ah yes that makes a lot of sense. I will send a V2 in a moment, as the line I
removed now means that it's not in order with the structure definition.

regards,

Peter.
