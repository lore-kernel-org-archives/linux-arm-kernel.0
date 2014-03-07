From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 09:52:23 +0000
Subject: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
In-Reply-To: <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140307095222.GG21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 05:28:37PM +0100, Maxime Ripard wrote:
> The Allwinner A31 SoC using that IP has a reset controller maintaining
> it reset unless told otherwise.
> 
> Add some optional reset support to the driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This appears to be causing some build errors in Olof's next builder
for many of the ARM platforms which make use of this:

drivers/i2c/busses/i2c-mv64xxx.c:924: undefined reference to `reset_control_assert'
drivers/i2c/busses/i2c-mv64xxx.c:904: undefined reference to `reset_control_assert'
drivers/i2c/busses/i2c-mv64xxx.c:771: undefined reference to `devm_reset_control_get'
drivers/i2c/busses/i2c-mv64xxx.c:778: undefined reference to `reset_control_deassert'

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
