From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2012 14:30:20 -0800
Subject: [PATCH 3/3] ARM: mx3: Let mx31 and mx35 enter in LPM mode in WFI
In-Reply-To: <1327084990-25402-3-git-send-email-fabio.estevam@freescale.com>
References: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
 <1327084990-25402-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOesGMhiSB2G7ffD7BLDVrqgQCLg5t+YU+=JZt6xfk4SFTjnpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the late comment, I just saw this patch as I got the pull
request from Sascha (I'll comment on that too), but the below sticks
out:


On Fri, Jan 20, 2012 at 10:43 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:


> diff --git a/arch/arm/mach-imx/crmregs-imx3.h b/arch/arm/mach-imx/crmregs-imx3.h
> index d7691e2..b4d2305 100644
> --- a/arch/arm/mach-imx/crmregs-imx3.h
> +++ b/arch/arm/mach-imx/crmregs-imx3.h
> @@ -77,6 +77,7 @@ MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR) : MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR))
> ?#define MXC_CCM_CCMR_SSI2S_MASK ? ? ? ? ? ? ? ? (0x3 << 21)
> ?#define MXC_CCM_CCMR_LPM_OFFSET ? ? ? ? ? ? ? ? 14
> ?#define MXC_CCM_CCMR_LPM_MASK ? ? ? ? ? ? ? ? ? (0x3 << 14)
> +#define MXC_CCM_CCMR_LPM_WAIT ?(cpu_is_mx35() ? (0x1 << 14) : 0)
> ?#define MXC_CCM_CCMR_FIRS_OFFSET ? ? ? ? ? ? ? ?11
> ?#define MXC_CCM_CCMR_FIRS_MASK ? ? ? ? ? ? ? ? ?(0x3 << 11)
> ?#define MXC_CCM_CCMR_UPE ? ? ? ? ? ? ? ? ? ? ? ?(1 << 9)

This isn't a great idea -- constants like these should be static
values. Since this is only used in one location, please just do a
runtime check and either mask in the value or not.



Thanks,

-Olof
