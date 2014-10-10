From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 09 Oct 2014 22:04:51 -0700
Subject: [PATCH] serial: of-serial: fix up PM ops on no_console_suspend
In-Reply-To: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
References: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <543768F3.6090703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2014 02:10 AM, Jingchang Lu wrote:
> Mandatorily disabling the uart clock will cause register access
> hung on "no_console_suspend". This patch add condition check on
> it and only disable the clock with console_suspend_enabled true.

It would be useful if the email/patch subject line said "V2", and there
was a changelog below.

> Signed-off-by: Joseph Lo <josephl@nvidia.com>

I don't think he did; he just suggested a small fix.

> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/tty/serial/of_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
...
