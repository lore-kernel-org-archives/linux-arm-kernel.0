From: detheridge@ti.com (Darren Etheridge)
Date: Thu, 24 Jul 2014 14:35:23 -0500
Subject: [PATCH RFA 1/2] drm/i2c: tda998x: allow re-use of tda998x support
 code
In-Reply-To: <E1XAKSc-0004YT-4Q@rmk-PC.arm.linux.org.uk>
References: <E1XAKSc-0004YT-4Q@rmk-PC.arm.linux.org.uk>
Message-ID: <53D15FFB.2040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2014 09:57 AM, Russell King wrote:
> Re-jig the TDA998x code so that we separate the functionality from the
> drm slave encoder implementation.  In several places, this is pretty
> clearly the correct thing to do, because we can avoid repetitively
> having to convert from the drm_encoder to the TDA998x private
> structure, particularly with the driver internal functions.
>
> The main motivation behind this change is to allow the code to be
> re-used with a standard drm_encoder and drm_connector implementation
> based on the component helpers, rather than the slave_encoder system.
> The addition of this will be in the following patch.
>
> We keep the slave_encoder interface as there are existing users of
> this; we need to give them time to convert and test.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> RFA = request for acks, but tested-by's would also be great,
> particularly from the tilcdc folk.
>

Works fine on BeagleBone Black (tilcdc + tda998x)

Tested against 3.16-rc6, using unmodified tilcdc driver, unmodified dts.

Version details:
Linux am335x-evm 3.16.0-rc6-00002-gf8a096f-dirty #40 SMP Thu Jul 24 
13:49:42 CDT 2014 armv7l GNU/Linux

Tried modetest with a variety of modes, all looked correct.
Tested as both built-in and modules.

Tested-by: Darren Etheridge <detheridge@ti.com>
