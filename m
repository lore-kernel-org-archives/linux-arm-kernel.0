From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Dec 2012 15:26:08 -0700
Subject: [PATCH 2/2 v2] pinctrl: skip deferral of hogs
In-Reply-To: <1355342027-2287-1-git-send-email-linus.walleij@stericsson.com>
References: <1355342027-2287-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50C90480.2010703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 12:53 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Up until now, as hogs were always taken at the end of the
> pin control device registration, it didn't cause any problem.
> But when starting to hog pins from the device core it will
> cause deferral of the pin controller device itself since the
> default pin fetch is done *before* the device probes, so
> let's fix this annoyance (which is also aesthetically ugly).
> 
> Also take some care to make sure that if any one map entry
> results in a deferral rather than a failure, then that
> deferral will take precedence.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
