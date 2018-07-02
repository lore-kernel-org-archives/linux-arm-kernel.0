From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 02 Jul 2018 13:18:42 +0300
Subject: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
In-Reply-To: <20180702180428.331b36c5@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
Message-ID: <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:
> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 

There are several serial IPs that have fractional divider built-in. None
is using any specific hooks. Why do you need in your case, esp. taking
into consideration that we have a custom ->set_termios() callback?

> patch1 introduces necessary hooks to 8250 core.
> patch2 implement the fractional divisor support for Synopsys DW 8250.
> 
> Jisheng Zhang (2):
>   serial: 8250: introduce get_divisor() and set_divisor() hook
>   serial: 8250_dw: add fractional divisor support
> 
>  drivers/tty/serial/8250/8250_core.c |  4 +++
>  drivers/tty/serial/8250/8250_dw.c   | 54
> +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |  8 +++++
>  include/linux/serial_8250.h         |  7 ++++
>  4 files changed, 73 insertions(+)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
