From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 15:27:00 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515164438.22258885@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB269CB.4080804@gmail.com> <20120515164438.22258885@skate>
Message-ID: <201205151527.01156.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Thomas Petazzoni wrote:
> On the naming side, we are really open to what the community prefers.
> We knew there would be quite a bit of discussion around this, because
> there's a lot quite a few Marvell SoCs supported in various places, and
> it's not obvious what's the right place and name for a new SoC family.
> 
> What about making it mach-marvell, which would contain the DT-enabled
> SoC support for Marvell SoCs? We can start with 370 and XP today, and
> gradually add future SoCs, or even port previous SoCs as they are moved
> to support the device tree.
> 
> Again we're really open on the solution. Lior from Marvell can give all
> the necessary input to explain how the SoC family is organized.

The problem with mach-marvell is that it would be confusing in the presence
of pxa/mmp which I would probably still leave out of that directory, since
they are rather different inside.

I think we can just start with the existing plat-orion directory until
someone comes up with a better place.

	Arnd
