From: robh@kernel.org (Rob Herring)
Date: Tue, 2 Feb 2016 15:19:43 -0600
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160202211943.GA18698@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:07:39PM +0100, Gregory CLEMENT wrote:
> From: Wilson Ding <dingwei@marvell.com>
> 
> Armada-3700's uart is a simple serial port, which doesn't
> support. Configuring the modem control lines. The uart port has a 32
> bytes Tx FIFO and a 64 bytes Rx FIFO
> 
> The uart driver implements the uart core operations. It also support the
> system (early) console based on Armada-3700's serial port.
> 
> Known Issue:
> 
> The uart driver currently doesn't support clock programming, which means
> the baud-rate stays with the default value configured by the bootloader
> at boot time
> 
> [gregory.clement at free-electrons.com: Rewrite many part which are too long
> to enumerate]
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/tty/serial/mvebu-uart.txt  |  13 +

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/kernel-parameters.txt                |   6 +
>  drivers/tty/serial/Kconfig                         |  22 +
>  drivers/tty/serial/Makefile                        |   1 +
>  drivers/tty/serial/mvebu-uart.c                    | 649 +++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |   3 +
>  6 files changed, 694 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
>  create mode 100644 drivers/tty/serial/mvebu-uart.c
