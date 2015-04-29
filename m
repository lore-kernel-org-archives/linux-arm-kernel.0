From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Apr 2015 16:34:33 +0000
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <20150429152527.GH2258@tarshish>
References: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
 <20150429142614.GE2258@tarshish>
 <BL2PR03MB3703DA9D4D52EC9524D627C83D70@BL2PR03MB370.namprd03.prod.outlook.com>
 <20150429150824.GF2258@tarshish>
 <BL2PR03MB37005C844BCB89007D176F683D70@BL2PR03MB370.namprd03.prod.outlook.com>
 <20150429152527.GH2258@tarshish>
Message-ID: <BL2PR03MB370B0B1622F9EE980A6835883D70@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> -----Original Message-----
> From: Baruch Siach [mailto:baruch at tkos.co.il]
> Sent: 2015?4?29? 10:25
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
> independent of SoCs.
> 
> Hi Shenwei Wang,
> On Wed, Apr 29, 2015 at 03:19:19PM +0000, Shenwei Wang wrote:
> > > -----Original Message-----
> > > From: Baruch Siach [mailto:baruch at tkos.co.il]
> > > Sent: 2015?4?29? 10:08
> > > To: Wang Shenwei-B38339
> > > Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
> > > devicetree at vger.kernel.org
> > > Subject: Re: [PATCH 1/1] ARM: imx: make the imx timer driver
> > > implementation independent of SoCs.
> > >
> > > When several SoC share the same IP block the usual convention is to
> > > name it in the compatible property string after the first SoC it
> > > appeared on. Just look at some binding documentation from
> > > Documentation/devicetree/bindings/timer/ to find examples. The
> > > allwinner,sun5i-a13-hstimer property is shared by A10s and
> > > A13 SoCs. The amlogic,meson6-timer is shared by Meson6 and Meson8
> > > SoCs, and so on.
> >
> > If the same IP block is shared with several SoCs, why we gave them
> > different compatible strings? If no changes in an IP block, I assume no changes
> in the relating driver as well.
> > In this assumption, I don't see any need to introduce a new compatible
> > string for an unchanged IP block in a new SoC.
> 
> That is exactly what I meant to say. Sorry that I was not clear enough.
> 
> When the same IP block is used in a newer generation SoC the same compatible
> property string is used. For that reason you can find in sun5i-a10s.dtsi the line
> 
> 	compatible = "allwinner,sun5i-a13-hstimer";
> 
That is what has been supported in this patch. Besides that, it can also support
different IP block versions in a SoC with different revision. For example,
Let's say: 
	hstimer version 1  in A13 revision 1.0
	hstimer version 2  in A13 revision 1.1

Shenwei


> baruch
> 
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open
> Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
