From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 14 Jan 2011 12:59:51 -0200
Subject: [PATCH] Introduce VPR200 board.
In-Reply-To: <1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
References: <1294962532-15790-1-git-send-email-marc@cpdesign.com.au>
	<1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <AANLkTi=KbD2FWnW2U7EG0gO8q2knVGL4uo0orbjf7y8c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jan 13, 2011 at 9:48 PM, Marc Reilly <marc@cpdesign.com.au> wrote:
....
>
> +config MACH_VPR200
> + ? ? ? bool "Support VPR200 platform"
> + ? ? ? select SOC_IMX35
> + ? ? ? select IMX_HAVE_PLATFORM_FSL_USB2_UDC
> + ? ? ? select IMX_HAVE_PLATFORM_IMX2_WDT
> + ? ? ? select IMX_HAVE_PLATFORM_IMX_UART
> + ? ? ? select IMX_HAVE_PLATFORM_IMX_I2C
> + ? ? ? select IMX_HAVE_PLATFORM_MXC_EHCI
> + ? ? ? select IMX_HAVE_PLATFORM_MXC_NAND

NAND seems to be unused on you board currently.

> + ? ? ? select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> + ? ? ? select IMX_HAVE_PLATFORM_MXC_PWM

PWM seems to be unused on you board currently.

I think you also need:
select MXC_ULPI if USB_ULPI

Please try building a kernel with only your board selected to make
sure it builds fine.

Regards,

Fabio Estevam
