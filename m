From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 23 Apr 2016 09:55:44 +1000
Subject: [PATCH v2 04/11] clocksource/moxart: Generalise timer for use
 on other socs
In-Reply-To: <571A5FBA.9010204@linaro.org>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-5-git-send-email-joel@jms.id.au>
 <571A5FBA.9010204@linaro.org>
Message-ID: <1461369344.3135.50.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-04-22 at 19:30 +0200, Daniel Lezcano wrote:
>?
> You probably can remove all the unused macro definition here for
> both?
> MOXART and ASPEED to have something just a couple of definition.

I disagree. Quite strongly in fact. These provide documentation (which
isn't otherwise publicly available) and this will be handy if somebody
wants to do something like add another timer etc.. in the future.

I much prefer when register definitions rather more exhaustive than
trimmed to be only what's used by the driver.

Cheers,
Ben
