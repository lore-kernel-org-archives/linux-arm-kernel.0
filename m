From: anilkumar.v@ti.com (Kumar, Anil)
Date: Tue, 5 Feb 2013 06:39:20 +0000
Subject: [PATCH 2/2] ARM: davinci: da850: add wdt OF_DEV_AUXDATA entry
In-Reply-To: <510FA2D4.7090807@mvista.com>
References: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
 <1359016695-10362-3-git-send-email-anilkumar.v@ti.com>
 <510FA09F.7030604@ti.com> <510FA2D4.7090807@mvista.com>
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C41F0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Serqei,

On Mon, Feb 04, 2013 at 17:30:20, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-02-2013 15:50, Sekhar Nori wrote:
> 
> > Auxdata is not evm specific. This can instead be called da850_auxdata_lookup[].
> 
> > Also, I dont think it is necessary to add auxdata in a separate patch
> > from dt nodes. So, I fixed these issues and came up with below patch. I
> > tested basic wdt reboot. reboot command is still broken (with or
> > without this patch). Can you please look at that?
> 
> > Thanks,
> > Sekhar
> 
> > ----8<----
> > From: "Kumar, Anil" <anilkumar.v@ti.com>
> > Date: Thu, 24 Jan 2013 14:08:14 +0530
> > Subject: [PATCH 1/1] ARM: davinci: da850: add wdt DT node
> 
> > Add da850 wdt DT node.
> 
> > Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> [...]
> 
> > diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> > index 8dd15c0..2800090 100644
> > --- a/arch/arm/boot/dts/da850.dtsi
> > +++ b/arch/arm/boot/dts/da850.dtsi
> > @@ -88,6 +88,11 @@
> >   				      19>;
> >   			status = "disabled";
> >   		};
> > +		wdt: wdt at 1c21000 {
> > +			compatible = "ti,davinci-wdt";
> > +			reg = <0x21000 0xfff>;
> 
>     Not 0x1000? This is region size, not upper limit.

Oh, you are right. It should be 0x1000. Thanks for correcting. 

In da850 timer1 is used as wdt and according to da850 data sheet.

Timer1 start address is 0x01C21000
Timer1 end address is   0x01C21FFF 

I had wrongly calculated upper limit. I will fix it. 

Thanks,
Anil
