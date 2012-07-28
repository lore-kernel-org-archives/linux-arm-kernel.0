From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 28 Jul 2012 15:07:15 +0100 (BST)
Subject: PXA 26x GPIO possible regression in kernel 3.3 and newer
In-Reply-To: <loom.20120727T164936-412@post.gmane.org>
Message-ID: <1343484435.81739.YahooMailClassic@web171606.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Damian,

That sounds familiar. In 3.3 the number of PXA builtin GPIOs
(PXA_NR_BUILTIN_GPIO) was increased from 128 to 192.
Consequently the board GPIO numbers all increased by 64.
On the iPAQ hx4700 that had the effect of pushing EGPIO
numbers from 192-199 to 256-263, beyond the 256 maximum.

The fix is to set ARCH_NR_GPIO in arch/arm/Kconfig to a
higher maximum (for example, the iPAQ hx4700 sets 264).

Regards,
Paul

--- On Fri, 27/7/12, Damian Czarnecki <dczarn@o2.pl> wrote:

> From: Damian Czarnecki <dczarn@o2.pl>
> Subject: PXA 26x GPIO possible regression in kernel 3.3 and newer
> To: linux-arm-kernel at lists.infradead.org
> Date: Friday, 27 July, 2012, 16:10
> Hello. This is my first post here. I
> have a problem with GPIOs on my board (HTC 
> Blue Angel PDA) with kernel versions 3.3 and newer.
> This board has PXA 263 CPU, which has 89 GPIOs
> and ASIC3 chip with GPIOs 192-255.
> The problem is that on kernel 3.3+ I can't access PXA GPIOs
> at all,
> but the ASIC3 works.
> Unfortunately, because of that I can't see whole kernel
> output or post dmesg 
> here,
> because PXA? GPIOs are needed for SD Card,USB and many
> more things.
> But I caught a line "gpiochip_add: registered GPIOs 192 to
> 255 on device: asic3",
> so it shows that? ASIC3 really is detected and works.
> Other errors are "gpio-keys failed to request gpio 0 error
> -22",
> "tmio-mmc: probe of tmio-mmc failed with error -22".
> With kernel 3.2 or older everything works. When requesting
> PXA GPIOs, it fails.
> Reading GPIOs hangs the system. I hope that somebody can
> help me.
> I know I haven't shown much info, but this is probably all I
> can get now.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
