From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Mar 2012 15:35:39 +0100
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <20120331134215.GA5012@opensource.wolfsonmicro.com>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <20120330180134.GJ22981@n2100.arm.linux.org.uk>
 <20120331134215.GA5012@opensource.wolfsonmicro.com>
Message-ID: <20120331143539.GB26661@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 02:42:15PM +0100, Mark Brown wrote:
> We need to change the AMBA bus so it does something better than what it
> does now and work out a good way to roll this out.  The more I think
> about this the less convinced I am that AMBA should have regualtor
> support in the bus itself at all.

How else does it power up the peripheral to read out the IDs?  You can't
bind a driver until you've read the ID, which implies that the bus layer
needs to have regulator support to turn the power on.
