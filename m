From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 26 Apr 2015 08:32:19 -0700
Subject: [PATCHv7 7/8] watchdog: omap_wdt: Fix memory leak on probe fail
In-Reply-To: <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <553D0503.7050207@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2015 04:11 AM, Timo Kokkonen wrote:
> Structures allocated on the beginning of the probe function must be
> freed in case of failure.

Really ? The functions are allocated with devm_kzalloc.
It might be useful to introduce an error on purpose, have the code
jump to your new label, and observe what happens.

Guenter
