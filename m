From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Aug 2013 20:51:46 +0200
Subject: [RFC 02/17] ARM: call clk_of_init from time_init
In-Reply-To: <5213D853.7070102@wwwdotorg.org>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308202244.56782.arnd@arndb.de> <5213D853.7070102@wwwdotorg.org>
Message-ID: <201308212051.46453.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 August 2013, Stephen Warren wrote:
> On 08/20/2013 02:44 PM, Arnd Bergmann wrote:
> > On Tuesday 20 August 2013, Stephen Warren wrote:

> Hmm. This probably isn't too hard. I /think/ the only reason the clocks
> are initialized early is:
> 
> * The PMC HW block is involved in the path of some interrupts (i.e. it
> inverts, or not, the IRQ input pin dedicated to the PMIC).
> 
> * So, that part of the PMC must be initialized early so that the IRQ
> polarity is correct.
> 
> * The PMC initialization is currently monolithic, and the PMC has some
> clock inputs, so the init routine ends up calling of_clk_get_by_name(),
> and hence clocks must be set up early too.
> 
> Perhaps if we just separate tegra_pmc_init() into two functions which
> initialize different parts of the PMC, we can get rid of the
> tegra_dt_init_irq() -> tegra_pmc_init() -> of_clk_get_by_name() call
> path, and hence move Tegra's call to of_clk_init() to the typical place.

That sounds good to me, thanks for looking into it.

	Arnd
