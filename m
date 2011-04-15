From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Apr 2011 22:45:05 +0200
Subject: [RFC] sanitizing crazy clock data files
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110415204505.GQ31990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:08:05PM +0200, Sascha Hauer wrote:
> The following tries to solve the chicken-egg problem we have with the
> common struct clk support and its users. It switches i.MX51 clock support
> to the new API. Included are some generic clock helpers for dividers and
> multiplexer. I first made them i.MX specific but after looking round in
> the other architectures I found them useful enough for other architectures
> aswell. If you could use the helpers but missing some bits please speak up.
> 
> There is one thing missing in Jeremys series and this series does not fix
> it. Once I add the new (un)prepare calls to drivers they won't compile
> without common struct clk support anymore. Maybe a
> 
> #ifndef CONFIG_USE_COMMON_STRUCT_CLK
> #define clk_prepare()
> #define clk_unprepare()
> #endif
> 
> will do.
This already exists in the latest version and works since v14[1].

Best regards
Uwe

[1]
http://thread.gmane.org/gmane.linux.ports.sh.devel/9755/focus=10241
has:

+static inline int clk_prepare(struct clk *clk) { return 0; }
+static inline void clk_unprepare(struct clk *clk) { }

in a !CONFIG_USE_COMMON_STRUCT_CLK cpp branch.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
