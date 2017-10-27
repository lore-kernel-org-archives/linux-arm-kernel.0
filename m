From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Oct 2017 11:04:45 +0100
Subject: [PATCH] drivers/pcmcia: Convert timers to use timer_setup()
In-Reply-To: <20171024102331.GA69696@beast>
References: <20171024102331.GA69696@beast>
Message-ID: <20171027100445.GI20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 03:23:31AM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: David Howells <dhowells@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-pcmcia at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/pcmcia/bcm63xx_pcmcia.c | 6 +++---
>  drivers/pcmcia/bfin_cf_pcmcia.c | 6 +++---
>  drivers/pcmcia/i82365.c         | 6 ++----
>  drivers/pcmcia/omap_cf.c        | 8 ++++----
>  drivers/pcmcia/pd6729.c         | 7 +++----
>  drivers/pcmcia/soc_common.c     | 7 +++----
>  drivers/pcmcia/tcic.c           | 8 +++-----
>  drivers/pcmcia/yenta_socket.c   | 7 +++----
>  8 files changed, 24 insertions(+), 31 deletions(-)

For soc_common.c:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
