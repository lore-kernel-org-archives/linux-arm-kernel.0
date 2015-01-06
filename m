From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 10:54:10 +0100
Subject: [PATCH] ARM: dts: sun6i: ippo-q8h-v5: Fix serial0 alias
In-Reply-To: <1419510319-32400-2-git-send-email-hdegoede@redhat.com>
References: <1419510319-32400-1-git-send-email-hdegoede@redhat.com>
 <1419510319-32400-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150106095410.GG7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 25, 2014 at 01:25:19PM +0100, Hans de Goede wrote:
> The Ippo q8h has its serial console connected to the r-uart. Adjust the
> serial0 alias to match.
> 
> This fixes the kernel serial console no longer working since 3.19-rc1, because
> 8250_dw.c now honors dt aliases, causing the serial console to be ttyS5 rather
> then being ttyS0, as it was in 3.18 and before.
> 
> Note that adjusting bootargs instead is not an acceptable fix, because
> console=ttyS0,115200 is used by a lot of bootscripts, etc. and this should
> continue to work.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/5f4fad5a/attachment.sig>
