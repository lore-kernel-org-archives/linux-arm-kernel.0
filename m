From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 19:48:20 +0100
Subject: [PATCH v2 4/4] arm64: Add APM X-Gene SoC 6.0Gbps SATA PHY DTS
 entries
In-Reply-To: <528CF956.3040104@cogentembedded.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-5-git-send-email-lho@apm.com>
 <528CF956.3040104@cogentembedded.com>
Message-ID: <201311201948.20682.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013, Sergei Shtylyov wrote:
> > --- a/arch/arm64/boot/dts/apm-storm.dtsi
> > +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> > @@ -193,5 +193,33 @@
> >                       reg = <0x0 0x17000014 0x0 0x100>;
> >                       mask = <0x1>;
> >               };
> > +
> > +             sataphy0: sataphy at 1f210000 {
> 
>     The nodes should better be named like "sata-phy at 1f210000" to better comply 
> with the "ethernet-phy" name we see in the ePAPR spec.

Well, since the phy can be used for other devices, I'd rather name it just
"phy", or possibly "serdes". The fact that it happens to be used for sata
here should not influence the naming when both the phy driver and the hardware
are completely generic.

	Arnd
