From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Dec 2015 00:37:08 +0100
Subject: [PATCH] ARM: socfpga: dts: Enable MMC support at correct place in
 the DT
In-Reply-To: <alpine.DEB.2.02.1512180638340.7406@linux-builds1>
References: <1450395544-9890-1-git-send-email-marex@denx.de>
 <alpine.DEB.2.02.1512180638340.7406@linux-builds1>
Message-ID: <201512210037.08547.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 18, 2015 at 01:45:50 PM, Dinh Nguyen wrote:
> On Thu, 17 Dec 2015, Marek Vasut wrote:
> > The socfpga.dtsi explicitly enabled MMC support, but not all boards are
> > equiped with an MMC card. There are setups which only have QSPI NOR.
> > Therefore, disable the MMC support on socfpga.dtsi level and enable it
> > on per-board basis.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Alan Tull <atull@altera.com>
> > Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Thor Thayer <tthayer@altera.com>
> > Cc: Vince Bridgers <vbridgers2013@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/socfpga.dtsi                    | 1 +
> 
> <snip>
> 
> > diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> > b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts index 54ed3f9..1a0c726
> > 100644
> > --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> > +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> > @@ -172,6 +172,7 @@
> > 
> >  &mmc0 {
> >  
> >  	vmmc-supply = <&regulator_3_3v>;
> >  	vqmmc-supply = <&regulator_3_3v>;
> > 
> > +	status = "okay";
> > 
> >  };
> >  
> >  &qspi {
> 
> This part doesn't apply to any of the upstream branches. "&qspi" has not
> been enabled yet, unless I have missed that patch? Can you please rebase
> this patch to my branch:

V2 is out, should be better.

I'm still working on the QSPI and had this patch way too high in the queue,
sorry about that ;-)

> git://git.kernel.org:pub/scm/linux/kernel/git/dinguyen/linux.git
> socfpga_for_next_v4.5_dts
> 
> Thanks,,
> Dinh

Best regards,
Marek Vasut
