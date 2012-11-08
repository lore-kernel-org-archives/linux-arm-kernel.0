From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 8 Nov 2012 12:54:23 -0600
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <509B666F.6080507@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
Message-ID: <509BFFDF.9040605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/08/2012 01:59 AM, Igor Grinberg wrote:

[snip]

> There is no reliable way to determine which source should be used in runtime
> for boards that do not have the 32k oscillator wired.

So thinking about this some more and given that we are moving away from
board files, if a board does not provide a 32kHz clock source, then this
should be reflected in the device-tree source file for that board.
Hence, at boot time we should be able to determine if a 32kHz clock
source can be used.

Cheers
Jon
