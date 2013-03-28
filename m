From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 29 Mar 2013 10:20:54 +1300
Subject: [PATCH] usb: ehci: mark unlink_empty_async_suspended() as
 __maybe_unused
In-Reply-To: <201303282116.21727.arnd@arndb.de>
References: <1364362080-8489-1-git-send-email-linux@prisktech.co.nz>
 <201303282109.47130.arnd@arndb.de> <201303282116.21727.arnd@arndb.de>
Message-ID: <5154B436.5080700@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/13 10:16, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Arnd Bergmann wrote:
>> Patch 4d053fdac3 "usb: ehci: unlink_empty_async_suspended() only used
>> with CONFIG_PM" tried to hide the unlink_empty_async_suspended function
>> inside of an #ifdef to work around an unused function warning.
> Hi Greg,
>
> Apparently the warning is now also in 3.8.5, so you might want to backport
> this fix as well after you send it upstream.
>
> 	Arnd
Grr, my bad - I originally wrote the patch with the forward decl 
#ifdef'd as well, but Alan pointed out that it didn't need to be. I 
thought I recompiled it after the change, but obviously not.

Thanks Arnd,

Regards
Tony P
