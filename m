From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 04 Nov 2011 11:18:44 +0100
Subject: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
In-Reply-To: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
References: <samsung_rs485>
	<1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
Message-ID: <4EB3BC04.1090203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2011 05:46 AM, Paul Schilling :
> Add RS485 tranmit/recieve control line capabilities
> This RS485 driver uses two methodes to determine if the transmit
> should be disabled.

[..]

> This patch adds an additional variable to the serial RS-485 struct so
> that a program can change the terminate token value via the IOCTL.

[..]

> diff --git a/include/linux/serial.h b/include/linux/serial.h
> index ef91406..826b1c0 100644
> --- a/include/linux/serial.h
> +++ b/include/linux/serial.h
> @@ -211,9 +211,12 @@ struct serial_rs485 {
>  #define SER_RS485_RTS_ON_SEND		(1 << 1)
>  #define SER_RS485_RTS_AFTER_SEND	(1 << 2)
>  #define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
> +#define SER_RS485_ALWAYS_LISTEN		(1 << 4)

This value is already in another patch (now in Linus' tree).

> +#define SER_RS485_TOGGLE_ON_TOKEN	(1 << 5)
>  	__u32	delay_rts_before_send;	/* Milliseconds */
>  	__u32	delay_rts_after_send;	/* Milliseconds */
> -	__u32	padding[5];		/* Memory is cheap, new structs
> +	__u32	toggle_token;			/* Token used to toggle to receive */

Do not forget to add this new value in the RS485 device tree bindings
[1] that appeared during this merge window. Once converted to device
tree, your platform may need to retrieve this value from it.

[1]: Documentation/devicetree/bindings/serial/rs485.txt

Best regards,
-- 
Nicolas Ferre
