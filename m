From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Dec 2013 11:31:56 +0000
Subject: [PATCH v3 14/36] mtd: st_spi_fsm: Add device-tree binding
 documentation
In-Reply-To: <CACRpkdb8=RRsNRKe4Nbefu2BJ4xHakmNjxFC1gwLea=bAmOz-A@mail.gmail.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-15-git-send-email-lee.jones@linaro.org>
 <CACRpkdaWXBchz78Yby11VpveBDtn6FrmupS=cnNYhvHgFJsBUw@mail.gmail.com>
 <20131202110304.GB31626@lee--X1>
 <CACRpkdb8=RRsNRKe4Nbefu2BJ4xHakmNjxFC1gwLea=bAmOz-A@mail.gmail.com>
Message-ID: <20131203113156.GB12031@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Dec 2013, Linus Walleij wrote:

> On Mon, Dec 2, 2013 at 12:03 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >> > +Optional properties:
> >> > +  - st,syscfg          : Phandle to boot-device system configuration registers
> >> > +  - st,boot-device-reg : Address of the aforementioned boot-device register(s)
> >> > +  - st,boot-device-spi : Expected boot-device value if booted via this device
> >> > +
> >> > +Example:
> >> > +       spifsm: spifsm at fe902000{
> >> > +               compatible         = "st,spi-fsm";
> >> > +               reg                =  <0xfe902000 0x1000>;
> >> > +               reg-names          = "spi-fsm";
> >> > +               pinctrl-0          = <&pinctrl_fsm>;
> >> > +               st,syscfg          = <&syscfg_rear>;
> >> > +               st,boot-device-reg = <0x958>;
> >> > +               st,boot-device-spi = <0x1a>;
> >>
> >> I don't think we should encode any register offsets whatsoever in device
> >> tree but maybe that's just me. (Yes, Stephen will beat me up about
> >> pin control single, but I consider that a special case.)
> >>
> >> I would just put the last two things as #defines into the driver file(s)
> >> or - if it's related to other syscfg registers and varies with SoC incarnation,
> >> as a #define in a shared header for that syscfg thing.
> >
> > No can do. This isn't _this_ device's register offset, this is a
> > syscfg register offset which a) there is no driver to apply specific
> > register offsets to and b) are liable to change oversubsequent SoCs.
> 
> So it can be in <linux/mfd/my-sysconfig-regs.h> as
> a
> 
> #define MY_SYSCON_V1_BOOT_DEV_REG 0x958
> #define MY_SYSCON_V1_BOOT_DEV_SPI 0x1a
> 
> The kernel should know which SoC is in use and
> act apropriately right?

And this have lots of machine_is() calls everywhere?

Sounds perfect. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
