From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 17:43:41 +0200
Subject: [PATCH 21/29] ARM: orion5x: use DT to describe I2C devices on
 edmini_v2
In-Reply-To: <20140413152840.GC10033@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-22-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413152840.GC10033@lunn.ch>
Message-ID: <20140413174341.070a225b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 13 Apr 2014 17:28:40 +0200, Andrew Lunn wrote:

> > +			i2c at 11000 {
> > +				status = "okay";
> > +				clock-frequency = <100000>;
> > +				#address-cells = <1>;
> > +
> > +				rtc at 32 {
> > +					compatible = "rs5c372a";
> 
> Hi Thomas
> 
> This should have a vendor prefix.

Ok, I was afraid this would have required adding an explicit DT binding
to the RTC driver, but that's not the case: of_modalias_node() strips
the vendor part of the compatible string.

Will fix for the next version, thanks.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
