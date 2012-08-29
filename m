From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Wed, 29 Aug 2012 07:56:25 +0200
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120829055625.GA17753@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Tue 28 Aug 2012 13:35:04 -0700 or thereabout, Mark Brown wrote:
> Rather than requiring platforms to select the generic clock API to make
> it available make the API available as a user selectable option unless the
> user either selects HAVE_CUSTOM_CLK (if they have their own implementation)
> or selects COMMON_CLK (if they depend on the generic implementation).
> 
> All current architectures that HAVE_CLK but don't use the common clock
> framework have selects of HAVE_CUSTOM_CLK added.
> 
> This allows drivers to use the generic API on platforms which have no need
> for the clock API at platform level.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This depends on having one of the patches I've sent adding a generic
> clkdev.h added merged - Arnd was expecting to merge one of those, there
> was just the lack of clarity about the most practical Kbuild hookup.
> 
>  arch/arm/Kconfig            |   12 ++++++++++++
>  arch/avr32/Kconfig          |    1 +

For the AVR32 related changes

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp>

-- 
mvh
Hans-Christian Egtvedt
