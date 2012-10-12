From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Oct 2012 16:16:06 +0200
Subject: [PATCH v2 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <5076E9F1.60200@gmail.com>
References: <1349969282-12676-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1349969282-12676-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <5076E9F1.60200@gmail.com>
Message-ID: <20121012161606.4cb97b48@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Thu, 11 Oct 2012 10:46:57 -0500, Rob Herring wrote:

> > +Required properties:
> > +- compatible: should be "marvell,neta".
> 
> This should be more specific such as "marvell,armada-xp-neta".
> 
> Or use 370 instead of xp. It should be which ever chip came first.

Is this really useful? The name of this network unit in Marvell is
simply "neta", and since it is associated with the vendor name Marvell
in the compatible string, it is actually unique: "marvell,neta".

The thing is that this unit is used in Armada 370, Armada XP, but also
other SoCs (which I am not sure are announced publicly as of today). So
if possible, we would prefer to keep the proposed "marvell,neta" name.
We could also change it to "marvell,ebu-neta" where EBU stands for
Embedded Business Unit, just like the "ebu" in arch/arm/mach-mvebu/,
but it sounds more logical to have just "marvell,neta".

Thanks again for your review,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
