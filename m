From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Oct 2013 15:00:36 +0200
Subject: [PATCH v10 2/7] ARM: hi3xxx: add board support with device tree
In-Reply-To: <1381828577-27998-3-git-send-email-haojian.zhuang@linaro.org>
References: <1381828577-27998-1-git-send-email-haojian.zhuang@linaro.org>
 <1381828577-27998-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201310151500.36959.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 October 2013, Haojian Zhuang wrote:
> 
> Add board support with device tree for Hisilicon Hi3620 SoC platform.
> 
> Changelog:
> v10:
> 1. Add .map_io() & debug_ll_io_init() back. Since debug_ll_io_init() is
> only called if .map_io() isn't assigned. Use .map_io() to setup static
> IO mapping that is used in clock driver.
> 

This seems like a step in the wrong direction. Why would you want to use
a static I/O mapping in the clock driver?

	Arnd
