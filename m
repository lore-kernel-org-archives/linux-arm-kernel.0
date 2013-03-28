From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 21:16:21 +0000
Subject: [PATCH] usb: ehci: mark unlink_empty_async_suspended() as
 __maybe_unused
In-Reply-To: <201303282109.47130.arnd@arndb.de>
References: <1364362080-8489-1-git-send-email-linux@prisktech.co.nz>
 <201303282109.47130.arnd@arndb.de>
Message-ID: <201303282116.21727.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, Arnd Bergmann wrote:
> Patch 4d053fdac3 "usb: ehci: unlink_empty_async_suspended() only used
> with CONFIG_PM" tried to hide the unlink_empty_async_suspended function
> inside of an #ifdef to work around an unused function warning.

Hi Greg,

Apparently the warning is now also in 3.8.5, so you might want to backport
this fix as well after you send it upstream.

	Arnd
