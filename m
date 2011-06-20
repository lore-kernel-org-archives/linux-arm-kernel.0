From: vitalivanov@gmail.com (Vitaliy Ivanov)
Date: Mon, 20 Jun 2011 12:32:49 +0300
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate linux/leds.h
	include
In-Reply-To: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
Message-ID: <BANLkTimjoiDxDX-_Qg4U6TSW6jjEa5xSsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jusper/Linus/All,

On Mon, Jun 20, 2011 at 11:40 AM, Jesper Juhl <jj@chaosbits.net> wrote:
> Remove the duplicate inclusion of linux/leds.h from
> arch/arm/mach-s3c2410/h1940-bluetooth.c that was added by commit 50e2d10d.
>
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
> ?h1940-bluetooth.c | ? ?1 -
> ?1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
> index 2c126bb..a5eeb62 100644
> --- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
> +++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
> @@ -18,7 +18,6 @@
> ?#include <linux/leds.h>
> ?#include <linux/gpio.h>
> ?#include <linux/rfkill.h>
> -#include <linux/leds.h>
>
> ?#include <mach/regs-gpio.h>
> ?#include <mach/hardware.h>
>
> --

Some time ago I already sent a patch to handle all the headers
duplication corrections. Please check this:

https://lkml.org/lkml/2011/6/16/301

It should handle all the cases you described at:

https://lkml.org/lkml/2011/6/20/72
https://lkml.org/lkml/2011/6/20/78
https://lkml.org/lkml/2011/6/20/75

I didn't receive any comments and still can see that it's not in
mainline Linus' tree.


Thanks,
Vitaliy
