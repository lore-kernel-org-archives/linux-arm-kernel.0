From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Aug 2013 19:28:10 +0200
Subject: [RFC 02/17] ARM: call clk_of_init from time_init
In-Reply-To: <20130822072524.8231.37219@quantum>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308212054.10417.arnd@arndb.de> <20130822072524.8231.37219@quantum>
Message-ID: <201308221928.10852.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 August 2013, Mike Turquette wrote:
> Some timers need to know their clock rate for the timer setup. This
> could be hard-coded (e.g. for some timer driven from a fixed 32Khz
> source) but it could also be from a clock capable of different rates
> that needs to be calculated.
> 
> I remember discussing the early clock init stuff for OMAP and there was
> an idea to not rely on the clock framework for timer init and just do
> some raw reads and compute the clock rate that way. Using the framework
> would be better of course.
> 

Just to be clear: I think we should initialize all clocks before timers,
just not any earlier like Tegra does.

	Arnd
