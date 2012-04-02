From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 17:00:36 +0100
Subject: [PATCH v5 2/4] mfd: mc13xxx-core: use regmap for register access
In-Reply-To: <1333262499-25871-3-git-send-email-marc@cpdesign.com.au>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
 <1333262499-25871-3-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120402160036.GA29808@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 04:41:37PM +1000, Marc Reilly wrote:
> This change converts the mc13xxx core to use regmap rather than direct
> spi r/w.
> The spidev member of mc13xxx struct becomes redundant and is removed.
> Extra debugging aids are added to mc13xxx_reg_rmw.

To repeat what I've said on previous versions please push this down into
regmap.  There's already extensive diagnostic features there, let's not
have people open coding things that are missing.
