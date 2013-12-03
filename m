From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Dec 2013 12:31:28 +0000
Subject: [PATCH v3 14/36] mtd: st_spi_fsm: Add device-tree binding
 documentation
In-Reply-To: <CACRpkdYdW+p4-sDNCr8L75YB+e6agiQfvfEX5V+wCs4iZUaKSQ@mail.gmail.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-15-git-send-email-lee.jones@linaro.org>
 <CACRpkdaWXBchz78Yby11VpveBDtn6FrmupS=cnNYhvHgFJsBUw@mail.gmail.com>
 <20131202110304.GB31626@lee--X1>
 <CACRpkdb8=RRsNRKe4Nbefu2BJ4xHakmNjxFC1gwLea=bAmOz-A@mail.gmail.com>
 <20131203113156.GB12031@lee--X1>
 <CACRpkdYdW+p4-sDNCr8L75YB+e6agiQfvfEX5V+wCs4iZUaKSQ@mail.gmail.com>
Message-ID: <20131203123128.GE12031@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Dec 2013, Linus Walleij wrote:

> On Tue, Dec 3, 2013 at 12:31 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 03 Dec 2013, Linus Walleij wrote:
> 
> >> So it can be in <linux/mfd/my-sysconfig-regs.h> as
> >> a
> >>
> >> #define MY_SYSCON_V1_BOOT_DEV_REG 0x958
> >> #define MY_SYSCON_V1_BOOT_DEV_SPI 0x1a
> >>
> >> The kernel should know which SoC is in use and
> >> act apropriately right?
> >
> > And this have lots of machine_is() calls everywhere?
> 
> No need for Mr. Everywhere to know about the SoC.
> 
> There are other ways to achieve this. arch/arm/mach-foo
> always knows which ASIC it is running on, and it can do
> various things:
> 
> - Add device tree fragments/overlays (OK high-tech, but
>   we're getting to this, inevitably)
> 
> - Selectively add AUXDATA, which is absolutely OK if
>   we can do autoprobing of hardware IMO.

I prefer our solution TBH.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
