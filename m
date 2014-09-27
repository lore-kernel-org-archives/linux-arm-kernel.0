From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 27 Sep 2014 16:47:44 +0400
Subject: [PATCH 4/4] serial: mxs-auart: enable PPS support
In-Reply-To: <1411811197-12638-5-git-send-email-j.uzycki@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
 <1411811197-12638-5-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <5426B1F0.9050006@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/27/2014 1:46 PM, Janusz Uzycki wrote:

> Enables PPS support in mxs-auart serial driver to make PPS API working.

> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> ---
>   drivers/tty/serial/mxs-auart.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index ab127a2..4f1ab98 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -787,6 +787,15 @@ static void mxs_auart_settermios(struct uart_port *u,
>   		mxs_auart_disable_ms(u);
>   }
>
> +static void mxs_auart_set_ldisc(struct uart_port *port, int new)
> +{
> +	if (new == N_PPS) {
> +		port->flags |= UPF_HARDPPS_CD;
> +		mxs_auart_enable_ms(port);
> +	} else
> +		port->flags &= ~UPF_HARDPPS_CD;

    The kernel coding style dictates that {} should be in both arms of the 
*if* statement.

[...]

WBR, Sergei
