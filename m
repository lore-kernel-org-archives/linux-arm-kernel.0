From: gbean@codeaurora.org (Greg Bean)
Date: Thu, 22 Jul 2010 10:22:42 -0700
Subject: [PATCH v4] gpio: sx150x: Add Semtech I2C sx150x gpio expander
	driver.
In-Reply-To: <20100722101753.c73604eb.randy.dunlap@oracle.com>
References: <1279818771-9428-1-git-send-email-gbean@codeaurora.org>
	<20100722101753.c73604eb.randy.dunlap@oracle.com>
Message-ID: <4C487E62.9080106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 >> +	bool "Semtech SX150x I2C GPIO expander"
 >> +	depends on I2C=y
 >> +	default n
 >> +	help
 >> +	  Say yes here to provide support for Semtech SX150-series I2C
 >> +	  GPIO expanders. Compatible models include:
 >
 > Just curious, not complaining, but why does this driver (and some others)
 > need to be built-in instead of having the option of being built as a
 > loadable module?

It's that way because it requires unexported symbols from genirq and 
I2C.  If this driver is allowed to be a module, it can't find the 
unexported genirq symbols, and if I2C is allowed to be a module, then a 
bunch of i2c_smbus stuff can't be resolved...

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
