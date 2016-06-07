From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 7 Jun 2016 12:46:50 -0700
Subject: [PATCH 2/2] ARM: dts: imx6: tag boards that have the HW
 workaround for ERR006687
In-Reply-To: <1464855906.9501.1.camel@pengutronix.de>
References: <1464794983-31484-1-git-send-email-l.stach@pengutronix.de>
 <1464794983-31484-3-git-send-email-l.stach@pengutronix.de>
 <20160601161729.GB19428@n2100.arm.linux.org.uk>
 <1464855906.9501.1.camel@pengutronix.de>
Message-ID: <20160607124650.1e69c658@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Jun 2016 10:25:06 +0200
Lucas Stach <l.stach@pengutronix.de> wrote:

> Am Mittwoch, den 01.06.2016, 17:17 +0100 schrieb Russell King - ARM
> Linux:
> > On Wed, Jun 01, 2016 at 05:29:43PM +0200, Lucas Stach wrote:  
> > > @@ -97,6 +97,7 @@
> > >  	phy-reset-gpios = <&gpio3 31 0>;
> > >  	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> > >  			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> > > +	fsl,err006687-war-present;  
> > 

Why can't we just have the quirk detect the interrupts-extended
property, which is not present on boards without the workaround.
Wouldn't that be better? No dts change needed.

> > war?  Any reason not to spell it out, or use the more natural
> > abbreviation "wa"?
> >   
> Apparently I've read too many documents where WAR is the abbreviation
> for workaround, so it felt completely natural to me. I agree that it
> would make sense to just spell it out to avoid any confusion.
> 
> Regards,
> Lucas
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
