From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 14:42:43 +0000
Subject: [PATCH 11/16] ARM: ux500: Do not attempt to register non-existent
 i2c devices on Snowball
In-Reply-To: <1334659448-11521-12-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-12-git-send-email-lee.jones@linaro.org>
Message-ID: <201204171442.43954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Lee Jones wrote:
> This patch prevents i2c devices which are not present on the Snowball
> low-cost development board from being registered. Devices such as;
> tc3589x, bu1780 and lp5521 are present on other supported boards,
> but are not located on Snowball.
> 

It looks like you only register the devices on mop500 now, but no longer
on hrev60+, which before this patch registers a subset.

	Arnd
