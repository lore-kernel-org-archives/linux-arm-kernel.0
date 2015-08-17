From: johan@kernel.org (Johan Hovold)
Date: Mon, 17 Aug 2015 13:16:25 +0200
Subject: [PATCH v2 8/9] usb: serial: mxuport: Simplify return statement
In-Reply-To: <05a5da593419a88886b1e75a0135d7b051b4bb76.1438695318.git.skarajga@visteon.com>
References: <cover.1438695318.git.skarajga@visteon.com>
 <05a5da593419a88886b1e75a0135d7b051b4bb76.1438695318.git.skarajga@visteon.com>
Message-ID: <20150817111625.GE7053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 02:04:35PM +0000, Karajgaonkar, Saurabh (S.) wrote:
> From: Saurabh Karajgaonkar <skarajga@visteon.com>
> 
> Replace redundant variable use in return statement.
> 
> Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
> ---
>  drivers/usb/serial/mxuport.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
> index 460a406..31a8b47 100644
> --- a/drivers/usb/serial/mxuport.c
> +++ b/drivers/usb/serial/mxuport.c
> @@ -1137,13 +1137,9 @@ static int mxuport_port_probe(struct usb_serial_port *port)
>  		return err;
>  
>  	/* Set interface (RS-232) */
> -	err = mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_INTERFACE,
> -				    MX_INT_RS232,
> -				    port->port_number);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_INTERFACE,
> +				     MX_INT_RS232,
> +				     port->port_number);

I do not consider this an improvement as it makes the final ctrl-request
call look different from the previous two without any real benefit.

I'll drop this one.

Johan
