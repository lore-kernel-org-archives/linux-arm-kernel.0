From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jun 2016 09:09:31 +0100
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <20160616001714.GN28218@codeaurora.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
 <20160614185517.GG28218@codeaurora.org>
 <20160614224807.GE1041@n2100.armlinux.org.uk>
 <20160616001714.GN28218@codeaurora.org>
Message-ID: <20160616080931.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 05:17:14PM -0700, Stephen Boyd wrote:
> On 06/14, Russell King - ARM Linux wrote:
> > On Tue, Jun 14, 2016 at 11:55:17AM -0700, Stephen Boyd wrote:
> > > On 06/14, Linus Walleij wrote:
> > > > +
> > > > +			pm8901-regulators {
> > > 
> > > I'd rather have regulators at 8901 and regulators at 8058. That way the
> > > node name is generic per ePAPR suggestions.
> > 
> > But ePAPR requires reg= if you specify a unit-address part of the
> > node name.
> > 
> 
> It seems the ePAPR also leaves this open to interpretation
> because it states:
> 
>   "The binding for a particular bus may specify additional, more
>   specific requirements for the format of reg and unit-address."
> 
> but we haven't done anything formal for the RPM "bus" so far. I'm
> not worried either way, just a fun fact!

Latest dtc with warnings enabled (W=1) warns if you don't follow what
I quoted.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
