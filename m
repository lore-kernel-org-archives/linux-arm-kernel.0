From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 21 Dec 2011 09:56:55 +0000
Subject: [PATCH v2] davinci: DA850 EVM: OHCI platform code
In-Reply-To: <1324452002-8388-1-git-send-email-prakash.pm@ti.com>
References: <1324452002-8388-1-git-send-email-prakash.pm@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6051CB9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prakash,

On Wed, Dec 21, 2011 at 12:50:02, Manjunathappa, Prakash wrote:
> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> On this board the OHCI port's power control and over-current signals from
> TPS2065 power switch are connected via GPIO2[4] and GPIO6[13] respectively,
> so we can implement the DA8xx OHCI glue layer's hooks for overriding the
> root hub port's power and over-current status bits.
> 
> We also have to properly set up the clocking mode in the CFGCHIP2 register,
> so that internal 24 MHz reference clock is fed to the USB 2.0 (MUSB) PHY and
> its output is used to clock the USB 1.1 (OHCI) PHY...
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

This is the third copy of OHCI platform setup code which is almost
the same except for the GPIO numbers. Can we attempt to consolidate
the GPIO case under drivers/usb/host/ohci-da8xx.c glue layer itself?
Of course, here should be a provision for non-GPIO based implementation
as well.

Sergei, any thoughts, comments?

Thanks,
Sekhar
