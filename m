From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Apr 2012 22:34:56 +0100
Subject: Tegra board file deprecation schedule
In-Reply-To: <6014194.Op4vnW6Cge@ax5200p>
References: <4F9B0E7C.1060408@wwwdotorg.org>
 <CAOesGMh3NY4cQERSQY-p0QsMtcCXyhkdGSGnnrckcz8-DPjbBw@mail.gmail.com>
 <6014194.Op4vnW6Cge@ax5200p>
Message-ID: <20120428213456.GD27792@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 06:09:32PM +0200, Marc Dietrich wrote:
> Another (maybe a bit off-topic) thing that puzzels me is the how to assign
> the clock to the nvec.

What's the nvec?

> The device needs the clock (tegra-i2c.2) but there is no sane way to get
> it. I was thinking to add an device name alias (nvec = tegra-i2c.2) to
> the board file so I can use clk_get(&pdev->dev, NULL) instead of 
> clk_get_sys which seems to be unwanted.

clk_get() is preferred in drivers which have struct device's to get them.
And if you know the device name, then I see no problem with the aliasing
approach.
