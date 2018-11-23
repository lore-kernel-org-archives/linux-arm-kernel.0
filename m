From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Nov 2018 09:02:35 -0800
Subject: [PATCH v4 1/4] ARM: OMAP1: ams-delta: Provide GPIO lookup table
 for NAND data port
In-Reply-To: <20181121110806.32076-2-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-2-jmkrzyszt@gmail.com>
Message-ID: <20181123170235.GG53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [181121 11:06]:
> Data port used by Amstrad Delta NAND driver is actually an OMAP MPUIO
> device, already under control of gpio-omap driver.  The NAND driver
> gets access to the port by ioremapping it and performs read/write
> operations.  That is done without any proteciton from other users
> legally manipulating the port pins over GPIO API.
> 
> The plan is to convert the driver to access the port over GPIO consumer
> API.  Before that is implemented, the driver can already obtain
> exclusive access to the port by requesting an array of its GPIO
> descriptors.
> 
> Add respective entries to the NAND GPIO lookup table.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Best to merge this along with the MFD patches:

Acked-by: Tony Lindgren <tony@atomide.com>
