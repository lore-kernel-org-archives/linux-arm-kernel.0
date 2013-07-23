From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Tue, 23 Jul 2013 09:57:17 +0200
Subject: [PATCH] ARM: S3C24XX: Add missing clkdev entries for s3c2440 UART
In-Reply-To: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <201307230957.17329.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 July 2013 21:42:45 Sylwester Nawrocki wrote:
> This patch restores serial port operation which has been broken since
> commit 60e93575476f90a72146b51283f514da655410a7
> serial: samsung: enable clock before clearing pending interrupts during
> init
>
> That commit only uncovered the real issue which was missing clkdev
> entries for the "uart" clocks on S3C2440. It went unnoticed so far
> because return value of clk API calls were not being checked at all
> in the samsung serial port driver.
>
> This patch should be backported to at least 3.10 stable kernel, since
> the serial port has not been working on s3c2440 since 3.10-rc5.
>
> Cc: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> [on S3C2440 SoC based Mini2440 board]
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
>
> [...]

Tested-by: Juergen Beisert <jbe@pengutronix.de>

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany ? ?| Fax: ? +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? ? ?| http://www.pengutronix.de/ ?|
