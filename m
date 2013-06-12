From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 16:46:30 +0200
Subject: [PATCH 21/33 v2] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <20130611110923.GB3330@laptop>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-22-git-send-email-lee.jones@linaro.org>
 <20130611110923.GB3330@laptop>
Message-ID: <201306121646.30279.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013, Lee Jones wrote:
> This patch enables clocks to be specified from Device Tree via phandles
> to the "prcc-kernel-clock" node.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 

I don't understand the design of the common clock subsystem here, but is it really
necessary to hardcode all the clocks using clk_reg_prcc_kclk() here *and* register
a clkdev *and* store the pointer in an array, when you can get all that information
from the device tree?

Mike?

	Arnd
