From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 19:21:01 +0100
Subject: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers to
 the PMSU node
In-Reply-To: <5304EE99.7000102@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
 <20140219170033.4ca8343b@skate>
 <5304EE99.7000102@free-electrons.com>
Message-ID: <20140219192101.4d92fa01@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 19 Feb 2014 18:49:13 +0100, Gregory CLEMENT wrote:

> I agree to use something like:
> 
> armada-370-xp-pmsu at 22000 {
> 	compatible = "marvell,armada-xp-pmsu"; /* new compatible string */

But this PMSU is identical on 370, no? So the marvell,armada-xp-pmsu
compatible string is maybe not the most appropriate one?

> 	reg = <0x22000 0x1000>;
> 	};
> 
> 
> and I think the best option would be to introduce a new compatible string
> for this. In the same time we continue to support the old compatible string
> but we print a big warning during the kernel boot that this compatible string
> is deprecated, and we will finally remove it a few release.

How do you support the new features of the L2 stuff with the old
compatible string? By substracting 0x100 to the register base address?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
