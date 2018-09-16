From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 16 Sep 2018 17:25:19 +0200 (CEST)
Subject: [PATCH 0/2] Improve VCHIQ cache line size handling
In-Reply-To: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
References: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
Message-ID: <1485322276.234696.1537111519181@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Phil Elwell <phil@raspberrypi.org> hat am 12. September 2018 um 18:42 geschrieben:
> 
> 
> Both sides of the VCHIQ communications mechanism need to agree on the cache
> line size. Using an incorrect value can lead to data corruption, but having the
> two sides using different values is usually worse.
> 
> In the absence of an obvious convenient run-time method to determine the
> correct value in the ARCH=arm world, the downstream Raspberry Pi trees used a
> Device Tree property, written by the firmware, to configure the kernel driver.
> This method was vetoed during the upstreaming process, so a fixed value of 32
> was used instead, and some corruptions ensued. This is take 2 at arriving at
> the correct value.
> 
> Part one of the fix is deriving the correct value from the ARM's cpuid register.
> Part two is a (seemingly cosmetic) correction of the Device Tree reg declaration
> used by the driver, but it doubles as an indication to the Raspberry Pi firmware
> that the kernel driver is running a recent kernel driver that chooses the
> correct value. As such I would like very much for the DT patch not to be merged
> before the driver patch - just tell me what hoops I need to jump through.
> 

even if this version isn't the best, the test results for vchiq_test -f 1 (using recent firmware 2018-09-10) are very good:

Raspberry 1 B, bcm2835_defconfig -> success
Raspberry 2 B, multi_v7_defconfig -> success
Raspberry 3 B, arm64/defconfig -> success

Thanks Stefan
