From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 24 Mar 2017 06:50:46 +0300
Subject: [PATCH 0/3] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <20170323210304.2181-1-nicolas.pitre@linaro.org>
References: <20170323210304.2181-1-nicolas.pitre@linaro.org>
Message-ID: <20170324035046.2mupvte2yzbgmslb@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Mar 23, 2017 at 05:03:01PM -0400, Nicolas Pitre wrote:
> Here's some numbers using a minimal ARM config.
> 
> When CONFIG_TTY=y, the following files are linked into the kernel:
> 
>    text    data     bss     dec     hex filename
>    8796     128       0    8924    22dc drivers/tty/n_tty.o
>   12846     276      44   13166    336e drivers/tty/serial/serial_core.o
>    4852     489      49    5390    150e drivers/tty/sysrq.o
>    1376       0       0    1376     560 drivers/tty/tty_buffer.o
>   13571     172     132   13875    3633 drivers/tty/tty_io.o
>    3072       0       0    3072     c00 drivers/tty/tty_ioctl.o
>    2457       2     120    2579     a13 drivers/tty/tty_ldisc.o
>    1328       0       0    1328     530 drivers/tty/tty_ldsem.o
>     316       0       0     316     13c drivers/tty/tty_mutex.o
>    2516       0       0    2516     9d4 drivers/tty/tty_port.o
>   51130    1067     345   52542    cd3e (TOTALS)
> 
> With CONFIG_TTY=n and CONFIG_MINITTY_SERIAL=y, the above is replaced by:
> 
>    text    data     bss     dec     hex filename
>    8776       8     108    8892    22bc drivers/tty/serial/minitty_serial.o

tty_baudrate.o is missing here. It is included in serial_core.o when 
CONFIG_TTY=y.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
