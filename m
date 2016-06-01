From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 01 Jun 2016 08:27:33 +0200
Subject: [PATCH v2] reset: Return -ENOTSUPP when not configured
In-Reply-To: <2b8732d98087e52edec39ec83a063912fcc23962.1464738402.git.johnyoun@synopsys.com>
References: <2b8732d98087e52edec39ec83a063912fcc23962.1464738402.git.johnyoun@synopsys.com>
Message-ID: <1464762453.3522.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

Am Dienstag, den 31.05.2016, 16:55 -0700 schrieb John Youn:
> Prior to commit 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo]
> functions wrappers"), the "optional" functions returned -ENOTSUPP when
> CONFIG_RESET_CONTROLLER was not set.
> 
> Revert back to the old behavior by changing the new
> __devm_reset_control_get() and __of_reset_control_get() functions to
> return ERR_PTR(-ENOTSUPP) when compiled without CONFIG_RESET_CONTROLLER.
> 
> Otherwise they will return -EINVAL causing users to think that an error
> occurred when CONFIG_RESET_CONTROLLER is not set.
> 
> Fixes: 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo] functions wrappers")
> Signed-off-by: John Youn <johnyoun@synopsys.com>
> ---
> 
> Hi Philipp,
> 
> Here are the changes as discussed previously. It just returns
> -ENOTSUPP directly when not configured. Tested and works with DWC2
> driver with Dinh's patch that adds the reset controller, using a
> configuration with no reset controller configured.

Thank you, I've applied the patch to my reset/next branch.

regards
Philipp
