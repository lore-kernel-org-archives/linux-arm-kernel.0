From: detheridge@ti.com (Darren Etheridge)
Date: Thu, 24 Jul 2014 14:36:20 -0500
Subject: [PATCH RFA 2/2] drm/i2c: tda998x: add component support
In-Reply-To: <E1XAKSh-0004YX-7c@rmk-PC.arm.linux.org.uk>
References: <E1XAKSh-0004YX-7c@rmk-PC.arm.linux.org.uk>
Message-ID: <53D16034.1040508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2014 09:57 AM, Russell King wrote:
> Add component helper support to the tda998x driver.  This permits the
> TDA998x to be declared as a separate device in device tree, and bound
> at the appropriate moment with a co-operating card driver.
>
> The existing slave_encoder interfaces are kept while there are existing
> users of it in order to prevent regressions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> RFA = request for acks, but tested-by's are also welcome, particularly
> for tilcdc hardware.
>

Works fine on BeagleBone Black (tilcdc + tda998x)

Tested against 3.16-rc6, using unmodified tilcdc driver, unmodified dts.

Version details:
Linux am335x-evm 3.16.0-rc6-00002-gf8a096f-dirty #40 SMP Thu Jul 24 
13:49:42 CDT 2014 armv7l GNU/Linux

Tried modetest with a variety of modes, all looked correct.
Tested as both built-in and modules.

Tested-by: Darren Etheridge <detheridge@ti.com>
