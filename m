From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 19 Mar 2012 12:00:15 +0000
Subject: [PATCH v4 2/4] mfd: mc13xxx-core: use regmap for register access
In-Reply-To: <1332129838-7080-3-git-send-email-marc@cpdesign.com.au>
References: <1332129838-7080-1-git-send-email-marc@cpdesign.com.au>
 <1332129838-7080-3-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120319120015.GA5705@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 03:03:56PM +1100, Marc Reilly wrote:
> This change converts the mc13xxx core to use regmap rather than direct
> spi r/w.
> The spidev member of mc13xxx struct becomes redundant and is removed.
> Extra debugging aids are added to mc13xxx_reg_rmw.
> Mutex init is moved to before regmap init.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though like I said it'd be good to get the rmw trace into regmap - if
it's useful to you here similar trace is probably going to be useful to
other users.
