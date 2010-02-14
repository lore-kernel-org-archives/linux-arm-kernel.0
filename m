From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Sun, 14 Feb 2010 22:54:32 +0100
Subject: [PATCH] iop: n2100: enable serial interrupt
In-Reply-To: <1266184405-21444-1-git-send-email-aaro.koskinen@iki.fi>
References: <1266184405-21444-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20100214215432.GB1637@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2010 at 11:53:25PM +0200, Aaro Koskinen wrote:

> Thecus N2100 has a jumper (J3/J4) to select whether the XINT1 interrupt
> line is connected to the second UHCI controller (position J3) or to
> the serial port UART (position J4). Currently, the kernel is hardcoded
> to assume the J3 position, and the serial port is always being used in
> polling mode.
> 
> The patch adds the IRQ autodetection flag for the serial port interrupt,
> and also marks it as shared (as the driver for the second UHCI controller
> will request the interrupt in any case). Now, when the jumper is set to
> the J4 position, the serial port will have an interrupt line, resulting
> in less CPU overhead and faster throughput.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Assuming that you've found this to actually work:

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
