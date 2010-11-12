From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 12 Nov 2010 23:40:41 +0800
Subject: Single binary kernel for all i.MX
In-Reply-To: <20101105121800.GV6017@pengutronix.de>
References: <20101105121800.GV6017@pengutronix.de>
Message-ID: <AANLkTim7znztJgGvZ5ZsV=ei=_W4YpjU3-5zWonrQ9ME@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

I'm studying at the implementation.  Can you please help me understand
how "addruart" in plat-mxc/include/mach/debug-macro.S works for single
image?

        .macro  addruart, rp, rv
        ldr     \rp, =UART_PADDR        @ physical
        ldr     \rv, =UART_VADDR        @ virtual
        .endm

We have this macro to get physical base address of UART.  However
UART_PADDR is defined as MX?_UART1_BASE_ADDR depending on
CONFIG_ARCH_MX*.  When all CONFIG_ARCH_MX* get defined in single image
case, how does UART_PADDR work for all CONFIG_ARCH_MX*?

Thanks.


On Fri, Nov 5, 2010 at 8:18 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi all,
>
> We are talking about a single kernel for longer now, here is something
> to test for the ones interested:
>
> git://git.pengutronix.de/git/imx/linux-2.6.git imx-single-kernel
>
> Compiling the imx_defconfig will result in a kernel which works
> i.MX21, i.MX27, i.MX31, i.MX35 and i.MX51 (not tested on i.MX21).
> i.MX1 does not work mainly because the kernel build will use some ARMv5
> and later instructions.
> The branch is based on the patches recently posted. It contains some
> hacks, so it still needs to be worked on.
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Regards,
Shawn
