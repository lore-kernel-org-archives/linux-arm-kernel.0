From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Jan 2015 07:57:01 +0200
Subject: [PATCH] serial: digicolor: fix sysrq handling
In-Reply-To: <1730002.vWGOEymGdz@wuerfel>
References: <1730002.vWGOEymGdz@wuerfel>
Message-ID: <20150114055701.GX2481@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jan 13, 2015 at 03:37:11PM +0100, Arnd Bergmann wrote:
> Trying to build the digicolor-usart driver when sysrq is disabled
> results in a compile error:
> 
> drivers/tty/serial/digicolor-usart.c: In function 'digicolor_uart_console_write':
> drivers/tty/serial/digicolor-usart.c:407:33: error: 'struct uart_port' has no member named 'sysrq'
> 
> Like a lot of other drivers, this one requires an #ifdef to avoid
> accessing the sysrq field here. While looking into this, I noticed
> that the case where sysrq support is enabled is also broken, because
> the driver fails to set the SUPPORT_SYSRQ macro.
> 
> This patch hopefully fixes both, but I do not hardware to test if sysrq
> is actually working now.

Unfortunately the hardware is not able to detect the BREAK condition, so it is 
not possible to support sysrq on this hardware. I'll send a patch removing 
sysrq reference.

Thanks for build testing and reporting.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
