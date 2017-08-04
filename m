From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 4 Aug 2017 12:18:28 +0200
Subject: [PATCH RFC 1/2] spi: pxa2xx: Convert to GPIO descriptor API where
 possible
In-Reply-To: <20170804101029.GV2369@lahna.fi.intel.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
 <20170804101029.GV2369@lahna.fi.intel.com>
Message-ID: <b411858d-6a09-a3bc-555d-b1e648b9c8ed@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-08-04 12:10, Mika Westerberg wrote:
> On Thu, Aug 03, 2017 at 01:40:32PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We still need to request/free GPIOs passed via the legacy path of
>> pxa2xx_spi_chip::gpio_cs, but we can use the gpiod API otherwise.
>>
>> Consistently use the descriptor API instead of the legacy one.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are some PXA2xx platforms under arch/arm/* which use this driver
> and legacy GPIOs. I wonder if this causes any problems with them?
> 
> That was one of the reasons I did not convert the whole driver over GPIO
> descriptors.

It shouldn't cause problems (famous last words) because I refrained from
changing the interfaces to them. References that come in as legacy GPIO
are still treated like that.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
