From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jun 2013 20:52:34 +0100
Subject: [PATCH 2/2] ARM: dts: mvebu: Add the i2c-bridge capability to
 the mv64xxx-i2c
In-Reply-To: <1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
 <1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130607195234.GZ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 05:42:23PM +0200, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature called
> i2c-bridge. This commit split the i2c information into armada-370.dtsi
> and armada-xp.dtsi. Most of the data remains the same and stay in the
> common file Armada-370-xp.dtsi. With this new feature the size of the
> registers are bigger for Armada XP and for this SoCs we add a new flag
> for the i2c-bridge capability.

Personally, I don't like this "i2c-bridge" flag either, but for a different
reason - i2c-bridge makes it sound like it's doing something it's not.

What it is doing is as you stated in the cover - it's an offload mechanism,
just like if it were possible to use DMA to supply the data to the I2C
interface.

I think Maxime is correct - this should be identified by a variation in
the compatible string, not by a flag in DT.
