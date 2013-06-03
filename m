From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 15:50:20 +0200
Subject: [PATCH 09/21] ARM: ux500: Supply the UART clocks lookup to the
 DBX500 DT
In-Reply-To: <1370266965-7901-10-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <1370266965-7901-10-git-send-email-lee.jones@linaro.org>
Message-ID: <196465635.q8uKhQ7JEM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 14:42:33 Lee Jones wrote:
> @@ -650,6 +650,9 @@
>                                <&dma 13 0 0x0>; /* Logical - MemToDev */
>                         dma-names = "rx", "tx";
>  
> +                       clocks = <&clk 83>, <&clk 40>;
> +                       clock-names = "uart0", "apb_pclk";
> +
>                         status = "disabled";
>                 };
>  
> @@ -662,6 +665,9 @@
>                                <&dma 12 0 0x0>; /* Logical - MemToDev */
>                         dma-names = "rx", "tx";
>  
> +                       clocks = <&clk 84>, <&clk 41>;
> +                       clock-names = "uart1", "apb_pclk";
> +
>                         status = "disabled";
>                 };
>  

This seems wrong: why would one of them have a clock named "uart0"
and the other one call it "uart1"? The clock name should be defined
in the binding and specific to the driver using it, not a string that
indicates where it is connected to.

	Arnd
