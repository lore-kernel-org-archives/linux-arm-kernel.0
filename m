From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 22:06:50 +0200
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <1460030811-13787-1-git-send-email-sr@denx.de>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
Message-ID: <10734204.V6uBDOOZ6M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 April 2016 14:06:51 Stefan Roese wrote:
> v3:
> - Used static MBus windows again, as suggested by Arnd
> - No new DT bindings needed for this. The MBus windows need to be
>   configured in the 'reg' property of the SPI controller. This is
>   done in a separate patch for the Armada platforms.
> - The direct mapping is configured and enable by adding the
>   specific MBus entry to the 'ranges' property of the 'soc' node
>   in the board dts file.

The new approach looks good to me, thanks!

As Mark pointed out, you still need to document the fact that
the SPI controller can now have additional entries in its 'reg'
property, and it would be nice to reference the mbus binding
from the spi controller binding as a help for people that
want to enable the direct mode.

	Arnd
