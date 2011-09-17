From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Sep 2011 22:56:59 +0200
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <20110917181907.GA16141@game.jcrosoft.org>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
	<20110917112321.GE16381@n2100.arm.linux.org.uk>
	<20110917181907.GA16141@game.jcrosoft.org>
Message-ID: <3353131.FJY7smc8i5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 September 2011 20:19:07 Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> I agree about it I just mean that if you have the same board with 2 SoC which
> are pin to pin compatible detect the soc type will be usefull as the soc
> resource may not be the same

In that scenario, you would put all SOC specific data into one .dtsi
file and all board data into another .dtsi file and then create a
description for the combination using a trivial .dts file with two
include statements. This is all solved outside of the kernel already,
so there is no need for infrastructure in the kernel.

	Arnd
