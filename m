From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 4 Aug 2017 13:29:29 +0300
Subject: [PATCH RFC 2/2] spi: pxa2xx: Only claim CS GPIOs when the slave
 device is created
In-Reply-To: <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka@siemens.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka@siemens.com>
Message-ID: <20170804102929.GY2369@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 01:40:33PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Avoid hogging chip select GPIOs just because they are listed for the
> master. They might be mulitplexed and, if no slave device is attached,
> used for different purposes. Moreover, this strategy avoids having to
> allocate a cs_gpiods structure.
> 
> Tested on the IOT2000 where the second SPI bus is connected to an
> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
> usage.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
