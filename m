From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 14:08:04 -0800
Subject: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe
 fails
In-Reply-To: <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20130201220804.GZ22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
> If the GPMC probe fails, devices that use the GPMC (such as ethernet
> chips, flash memories, etc) can still allocate a GPMC chip-select and
> register the device. On the OMAP2420 H4 board, this was causing the
> kernel to crash after the gpmc probe failed and the board attempted
> to start networking. Prevent this by marking all the chip-selects as
> reserved by default and only make them available for devices to request
> if the GPMC probe succeeds.

Thanks applying into omap-for-v3.9/gpmc.

Regards,

Tony
