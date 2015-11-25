From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 21:28:43 +0100
Subject: [PATCH v2] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <201511260435.1AHQOCP1%fengguang.wu@intel.com>
References: <201511260435.1AHQOCP1%fengguang.wu@intel.com>
Message-ID: <19146462.9tlorCPL8k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 November 2015 04:21:09 kbuild test robot wrote:
>    386          aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
>  > 387          if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
>    388                  clk_prepare_enable(aemif);
>    389  
> 

That is an extra ')' after aemif.

	Arnd
