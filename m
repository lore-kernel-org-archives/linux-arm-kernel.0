From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 11:59:11 +0100
Subject: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
In-Reply-To: <20180318200715.363f3135@dell-desktop.home>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com>
 <6329fbb6-13a1-41fe-f6cf-f2f0d4b2e5f9@arm.com>
 <20180318200715.363f3135@dell-desktop.home>
Message-ID: <20180319105911.o63otbbhld54br4r@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 08:07:15PM +0100, Myl?ne Josserand wrote:
> Hello Mark,
> 
> Please, excuse me for this late answer and thank you for the review!
> 
> On Wed, 7 Mar 2018 12:18:33 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > On 23/02/18 13:37, Myl?ne Josserand wrote:
> > > On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.  
> > 
> > Only on A7? Is that specific to your platform?
> 
> I do not really know other Allwinner's platforms about this subject. At
> least, the sun9i-a80 which is a Cortex-a15/a7 does not need that but it
> is necessary for sun8i-a83t which is a cortex-a7. Maybe, Chen-Yu or
> Maxime could help us on it.

This is not related to the CPU.

On all the other SoCs but the A80 and the A83t, U-Boot will boot the
system in HYP, and while switching to non-secure will setup CNTVOFF on
the boot CPU.

On the A80 and A83t, U-Boot will execute the kernel in secure, it will
not switch to non-secure, and CNTVOFF will not be set on the boot CPU.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
