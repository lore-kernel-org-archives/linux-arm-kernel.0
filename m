From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 4 Apr 2014 17:20:12 +0200
Subject: [PATCH] watchdog: imx2_wdt: handle enabled watchdog properly
In-Reply-To: <1396623242-15234-1-git-send-email-agust@denx.de>
References: <1396623242-15234-1-git-send-email-agust@denx.de>
Message-ID: <20140404152011.GC5529@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 04:54:01PM +0200, Anatolij Gustschin wrote:
> If the watchdog is already enabled (e.g. started by the boot loader),
> we need to handle this case properly and start reloading the watchdog
> time-out counter as frequently as needed.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Uh, this driver has not been converted to use the watchdog framework
yet? I'd suggest this should be the first step.

@Wim: Does the watchdog core already handle the case that the wdt might
have been started by the bootloader?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140404/e7bcaf92/attachment.sig>
