From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Sep 2012 08:56:52 +0200
Subject: [PATCH v3 6/9] ARM: mvebu: add pinctrl device in DT for Armada
 370/XP SoCs
In-Reply-To: <504FB9D7.3030205@wwwdotorg.org>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <504FB9D7.3030205@wwwdotorg.org>
Message-ID: <20120912085652.21d3232f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 11 Sep 2012 16:23:19 -0600,
Stephen Warren <swarren@wwwdotorg.org> a ?crit :

> On 09/10/2012 02:39 AM, Sebastian Hesselbarth wrote:
> > From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > 
> > The Armada 370 and XP SoCs have configurable muxing for a certain
> > number of their pins, controlled through a pinctrl driver.
> 
> Hmmm. I'd be tempted just to put the entire node definition there;
> putting in a .dtsi file just to share the reg property doesn't seem
> especially useful.

When you say "here" you're mentioning the SoC-specific .dtsi files (i.e
the ones in PATCH 7/9 and PATCH 8/9), correct?

> > The 'compatible' property is defined in the SoC-specific .dtsi files,
> > since the compatible string identifies the number of pins and other
> > SoC-specific properties.
> 
> > diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> 
> > +		pinctrl at d0018000 {
> 
> If this is the only pinctrl instance, you'd typically name the node just
> "pinctrl", since the "@d0018000" isn't needed to get unique node names.

Ack.

> > +			reg = <0xd0018000 0x38>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> 
> What is "ranges" for; this isn't a memory-mapped bus, right?

Ack.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
