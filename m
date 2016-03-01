From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Mar 2016 21:25:54 +0100
Subject: [PATCH 3/3] ARM: dts: NSP: Add PWM Support to DT
In-Reply-To: <1456854169-9788-4-git-send-email-yendapally.reddy@broadcom.com>
References: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com>
 <1456854169-9788-4-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <9193665.m7s4avOK78@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 March 2016 12:42:49 Yendapally Reddy Dhananjaya Reddy wrote:
>                 };
>  
> +               pwm: pwm at 31000 {
> +                       compatible = "brcm,iproc-pwm";
> +                       reg = <0x31000 0x28>;
> +                       clocks = <&osc>;
> +                       #pwm-cells = >;
> +                       status = "disabled";
> +               };
> 

Should this also list "brcm,kona-pwm" as compatible? From patch
1, it sounds like that was the original one.

	Arnd
