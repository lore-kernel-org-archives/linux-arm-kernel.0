From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 5 Jul 2013 10:29:51 -0400
Subject: [PATCHv1] arm: armada: Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <878v1mgh4x.fsf@natisbad.org>
References: <878v1mgh4x.fsf@natisbad.org>
Message-ID: <20130705142951.GE2569@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 11:16:46PM +0200, Arnaud Ebalard wrote:
> 
> All hardware parts of the (Armada 370 based) NETGEAR ReadyNAS 102 are
> supported by mainline kernel (USB 3.0 rear ports, USB 2.0 front port,
> Gigabit controller and PHY, serial port, leds, buttons, SATA ports,
> G762 fan controller) except for:
> 
>  - the Intersil ISL12057 I2C RTC Chip,
>  - the Armada NAND controller.
> 
> Support for both of those is currently work in progress and does not
> prevent boot.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> Hi Jason and Andrew,
> 
> As requested
> 
>  - this version is tested against current head of linus tree (+ I2C
>    fixes for a race condition; for details, see message #94 of
>    http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=622325).
>  - nand layout entry and ISL12057 entry have been removed until support
>    is available in mainline kernel for eahc of those
>  - clock, gpio led and keys have been made siblings of soc, memory and
>    chosen (reported by Sebastian).
> 
> Is it still acceptable for current merge window or am I too late?

Unfortunately, it's too late for v3.11.  The arm-soc cutoff is typically
-rc6 or so.  Which usually means we need to see it on lakml by -rc5.
So, you're ahead of schedule for v3.12 :-P

However, with any luck, maybe Ezequiel will have something ready for the
nand driver in time as well...

thx,

Jason.
