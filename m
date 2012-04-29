From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Apr 2012 19:56:19 +0100
Subject: Tegra board file deprecation schedule
In-Reply-To: <1388911.4olGsS8Z0g@ax5200p>
References: <4F9B0E7C.1060408@wwwdotorg.org> <6014194.Op4vnW6Cge@ax5200p>
 <20120428213456.GD27792@n2100.arm.linux.org.uk> <1388911.4olGsS8Z0g@ax5200p>
Message-ID: <20120429185619.GA32152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 29, 2012 at 08:11:56PM +0200, Marc Dietrich wrote:
> On Saturday 28 April 2012 22:34:56 Russell King - ARM Linux wrote:
> > clk_get() is preferred in drivers which have struct device's to get them.
> > And if you know the device name, then I see no problem with the aliasing
> > approach.
> 
> I'm just looking for a way to use clk_get if two devices, tegra-i2c and nvec 
> (or tegra-i2c-slave in the future) share the same clock. 

Easy if you know the device names for each.  You just have two clk_lookup
entries which point at the exact same struct clk, one for each device.
