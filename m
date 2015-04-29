From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Apr 2015 15:19:19 +0000
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <20150429150824.GF2258@tarshish>
References: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
 <20150429142614.GE2258@tarshish>
 <BL2PR03MB3703DA9D4D52EC9524D627C83D70@BL2PR03MB370.namprd03.prod.outlook.com>
 <20150429150824.GF2258@tarshish>
Message-ID: <BL2PR03MB37005C844BCB89007D176F683D70@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> -----Original Message-----
> From: Baruch Siach [mailto:baruch at tkos.co.il]
> Sent: 2015?4?29? 10:08
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
> independent of SoCs.
> 
> Hi Shenwei Wang,
> 
> On Wed, Apr 29, 2015 at 02:55:52PM +0000, Shenwei Wang wrote:
> > > -----Original Message-----
> > > From: Baruch Siach [mailto:baruch at tkos.co.il]
> > > Sent: 2015?4?29? 9:26
> > > To: Wang Shenwei-B38339
> > > Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
> > > devicetree at vger.kernel.org
> > > Subject: Re: [PATCH 1/1] ARM: imx: make the imx timer driver
> > > implementation independent of SoCs.
> > >
> > > On Wed, Apr 29, 2015 at 09:14:41AM -0500, Shenwei Wang wrote:
> > > > There are 4 versions of the timer hardware on Freescale MXC hardware.
> > > > --Version 0: MX1/MXL
> > > > --Version 1: MX21, MX27.
> > > > --Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q --Version 3:
> > > > MX6DL, MX6SX
> > > >
> > > > This patch has removed the SoC related codes, and implemented the
> > > > driver directly upon the hardware timer IP version.
> > > >
> > > > The new driver can be installed via device tree or the direct
> > > > function call to mxc_timer_init in order to support imx legacy
> > > > systems like
> > > > MX21 and MX27.
> > > >
> > > > For the device tree implementation, the driver is compatible with
> > > > the current bindings like "fsl,imx6q-gpt", but for future dts
> > > > file, the string like "fsl,imx-gpt-v2" without SoC information is
> recommended.
> > >
> > > That is not the usual convention for IP block versions.
> > >
> > > Please Cc the devicetree list (added).
> >
> > Thank you for the comments. What is the current naming rules for IP
> > block version? It would be appreciated if you could provide an example.
> 
> When several SoC share the same IP block the usual convention is to name it in
> the compatible property string after the first SoC it appeared on. Just look at
> some binding documentation from Documentation/devicetree/bindings/timer/ to
> find examples. The allwinner,sun5i-a13-hstimer property is shared by A10s and
> A13 SoCs. The amlogic,meson6-timer is shared by Meson6 and Meson8 SoCs, and
> so on.
> 
If the same IP block is shared with several SoCs, why we gave them different compatible 
strings? If no changes in an IP block, I assume no changes in the relating driver as well. 
In this assumption, I don't see any need to introduce a new compatible string for an 
unchanged IP block in a new SoC.

Shenwei
> baruch
> 
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open
> Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
