From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 21:28:31 -0600
Subject: [PATCH] ARM: BCM2835: Skip doing our own iotable_init()
 initialization.
In-Reply-To: <1429811351-12600-1-git-send-email-eric@anholt.net>
References: <1429811351-12600-1-git-send-email-eric@anholt.net>
Message-ID: <5539B85F.1060409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2015 11:49 AM, Eric Anholt wrote:
> The only thing we were using this 16MB mapping of IO peripherals for
> was the uart's early debug mapping.  If we just drop the map_io hook,
> the kernel will call debug_ll_io_init() for us, which maps the single
> page needed for the device.

I /think/ debug_ll_io_init() didn't exist (or didn't map memory) when I
first upstreamed RPi support. Anyway,

Tested-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
