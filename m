From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 4 Aug 2017 13:10:29 +0300
Subject: [PATCH RFC 1/2] spi: pxa2xx: Convert to GPIO descriptor API
 where possible
In-Reply-To: <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
Message-ID: <20170804101029.GV2369@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 01:40:32PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We still need to request/free GPIOs passed via the legacy path of
> pxa2xx_spi_chip::gpio_cs, but we can use the gpiod API otherwise.
> 
> Consistently use the descriptor API instead of the legacy one.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

There are some PXA2xx platforms under arch/arm/* which use this driver
and legacy GPIOs. I wonder if this causes any problems with them?

That was one of the reasons I did not convert the whole driver over GPIO
descriptors.
