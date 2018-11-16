From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 16 Nov 2018 17:11:22 +0100
Subject: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
 <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
Message-ID: <20181116161122.hhvslbzdujxpk3up@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 05:01:28PM +0100, Uwe Kleine-K?nig wrote:
> Other than that I think the patch is fine

Thinking again, I wonder why not just do:

static inline struct clk *clk_get_optional(struct device *dev, const char *id)
{
	struct clk *c = clk_get(dev, id);

	if (c == ERR_PTR(-ENOENT))
		return NULL;
	else
		return c;
}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
