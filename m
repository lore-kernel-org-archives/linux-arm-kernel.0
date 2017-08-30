From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 30 Aug 2017 21:58:49 +0000
Subject: [PATCH v2 0/5] make XIP kernel .data compressed in ROM
In-Reply-To: <20170830025547.30347-1-nicolas.pitre@linaro.org>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
Message-ID: <SG2PR06MB1165EF18A363D9CC4C5531FE8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 29, 2017 1, Nicolas Pitre wrote:
> This patch series provides the ability to store the XIP kernel .data
> segment compressed in ROM. It has to be copied to RAM anyway so
> storing it uncompressed is arguably a waste of ROM resources.
> 
> While at it, the copying of .data (when not compressed) and the
> clearing of .bss is now performed using optimized string routines
> rather than doing it one word at a time.

Tested on my XIP system (Cortex-A9) and it seems to work OK.


> This work highlighted some defficiencies in linker scripts, especially
> the XIP one. So this also includes linker script cleanups and fixes.

Thank you for this!



If you're curious, here are some numbers from my system:

Original xipImage size: 4,190,068 bytes
xipImage size with CONFIG_XIP_DEFLATED_DATA=y: 3,985,227 bytes

A 204,841 byte reduction in image size (4.89%)



Chris
