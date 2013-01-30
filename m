From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 30 Jan 2013 21:50:36 +0100
Subject: [PATCH] ARM: kirkwood: of_serial: fix clock gating by removing
 clock-frequency
In-Reply-To: <1359493774-27627-1-git-send-email-jason@lakedaemon.net>
References: <1359493774-27627-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20130130205035.GA20203@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Jan 29, 2013 at 09:09:34PM +0000, Jason Cooper wrote:
> When DT support for kirkwood was first introduced, there was no clock
> infrastructure.  As a result, we had to manually pass the
> clock-frequency to the driver from the device node.
> 
> Unfortunately, on kirkwood, with minimal config or all module configs,
> clock-frequency breaks booting because of_serial doesn't consume the
> gate_clk when clock-frequency is defined.
> 
> The end result on kirkwood is that runit gets gated, and then the boot
> fails when the kernel tries to write to the serial port.
> 
> Fix the issue by removing the clock-frequency parameter from all
> kirkwood dts files.
> 
> Booted on dreamplug without earlyprintk and successfully logged in via
> ttyS0.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---

If you like, you can add my
Tested-by: Simon Baatz <gmbnomis@gmail.com>
(On IB-NAS6210 serial console, earlyprintk and successful login via
ttyS0)


- Simon
