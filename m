From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 11:34:29 +0100
Subject: [PATCH V7 07/10] SPEAr13XX: dts: Add PCIe node information
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189FD519B2E@EAPEX1MAIL1.st.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
 <7430033.eK9aHCDe8b@wuerfel>
 <2CC2A0A4A178534D93D5159BF3BCB66189FD519B2E@EAPEX1MAIL1.st.com>
Message-ID: <201403141134.30157.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 March 2014, Mohit KUMAR DCG wrote:
> Hello Arnd,
> 
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: Friday, February 28, 2014 5:28 PM
> > To: Mohit KUMAR DCG
> > Cc: Pratyush ANAND; Viresh Kumar; spear-devel; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH V7 07/10] SPEAr13XX: dts: Add PCIe node information
> > 
> > On Friday 28 February 2014 17:25:00 Mohit Kumar wrote:
> > > +                       interrupts = <0 68 0x4>;
> > > +                       interrupt-map-mask = <0 0 0 0>;
> > > +                       interrupt-map = <0x0 0 &gic 68>;
> > >
> > 
> > From the discussion we just had on the imx version of this driver, I suspect
> > what you want instead is to drop the interrupts property and fix the interrupt
> > map to be
> > 
> > interrupt-map = <0x0 0 &gic 0 68 0x4>;
> > 
> 
> - yes, I should have fix interrupt map. Pls let us know if any other point needs to be
> Incorporated in this series.
> 

I just noticed from your code that you use the 68 interrupt both for MSI and
legacy interrupts. Is this what the hardware does? I was asking above that
the 'interrupts' property be dropped, but I guess that won't work if it's
also used for MSI.

Please clarify.

Aside from this, all patches

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
