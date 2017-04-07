From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Apr 2017 16:49:29 -0700
Subject: [GIT PULL] Reset controller fixes for v4.11, part 2
In-Reply-To: <1491387689.2381.75.camel@pengutronix.de>
References: <1491387689.2381.75.camel@pengutronix.de>
Message-ID: <20170407234929.GA8992@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 12:21:29PM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> please consider merging this tag for v4.11, which fixes another bug that
> slipped through in commit bb475230b8e5 ("reset: make optional functions
> really optional"). If RESET_CONTROLLER is enabled,
> devm_reset_controller_get_optional must return NULL after the API
> change, if called from a driver that is not probed via device tree
> (dev->of_node == NULL). This is the case for recent Intel boards using
> the 8250_dw driver, which will be changed to rely on that behaviour 
> in v4.12.
> 
> regards
> Philipp
> 
> The following changes since commit 0ca10b60ceeb5372da01798ca68c116ae45a6eb6:
> 
>   reset: fix optional reset_control_get stubs to return NULL (2017-03-21 18:19:43 +0100)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.11-2
> 
> for you to fetch changes up to 62e24c5775ecb387a3eb33701378ccfa6dbc98ee:
> 
>   reset: add exported __reset_control_get, return NULL if optional (2017-04-04 17:36:10 +0200)

Merged, thanks.


-Olof
