From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 18:17:41 +0200
Subject: [PATCH 1/5] ARM: ux500: Move DMA40 platform data includes file
 out to include/
In-Reply-To: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201304081817.42031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Lee Jones wrote:
> The pin names for DB8500 based platforms need to be moved out of
> ux500 platform data and into the new proper location in include/
> linux/platform_data/. This way we an reference them from other
> external locations, such as the main DMA50 driver(s).
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Hmm, not sure about this one. The slave numbers are not really platform_data
and I think they should not be exposed to drivers. It makes sense to
keep the numbers for the memcpy channels in the driver itself as they
are hardwired in the driver, but the slave channels should stay in the
platform I think.

	Arnd
