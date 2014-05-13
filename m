From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 13 May 2014 13:11:44 +0200
Subject: [PATCH 1/1] usb: core: Kconfig: refine the description for
 CONFIG_USB_OTG
In-Reply-To: <1399947567-18958-1-git-send-email-peter.chen@freescale.com>
References: <1399947567-18958-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20140513111144.GA29360@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 10:19:27AM +0800, Peter Chen wrote:
> the user should only select it when the board supports HNP and SRP,
> it should NOT be selected if the board only supports dual-role
> switch through ID pin.
> 
> There is a discussion for it:
> http://marc.info/?l=linux-arm-kernel&m=139994896101516&w=2
> http://marc.info/?l=linux-usb&m=139994881701504&w=2
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/core/Kconfig |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index cb8e991..158048b 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -54,13 +54,15 @@ config USB_OTG
>  	default n
>  	help
>  	  The most notable feature of USB OTG is support for a
> -	  "Dual-Role" device, which can act as either a device
> -	  or a host. The initial role is decided by the type of
> -	  plug inserted and can be changed later when two dual
> -	  role devices talk to each other.
> +	  otg device, which can act as either a device or a host.
> +	  The initial role is decided by the type of plug inserted
> +	  and can be changed using HNP (Host Negotiation Protocol)
> +	  later when two otg devices talk to each other.
>  
>  	  Select this only if your board has Mini-AB/Micro-AB
> -	  connector.
> +	  connector and supports HNP and SRP (Session Request Protocol).
> +	  If the board only supports dual-role switch through ID
> +	  pin, this configuration should not be selected.

That's really lame.  What happened to our "all modconfig should work"
goal?  Why can't you dynamically detect that this is not a config that
works and handle it?

And this is just the OTG "core", not any specific hardware, so why
should it matter?

greg k-h
