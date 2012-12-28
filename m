From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Dec 2012 17:38:18 +0000
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
In-Reply-To: <20121228171749.GA6152@lunn.ch>
References: <20121228171749.GA6152@lunn.ch>
Message-ID: <20121228173818.GD24604@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 06:17:49PM +0100, Andrew Lunn wrote:
> Hi Josh
> 
> What compiler version are you using to get the opps?

It's a section mismatch warning.  Just look at the code line and compare
it with the disassembly.  Oh, the code line indicates that the code is
no longer present.  Why would that be?

static struct clk __init *mvebu_clk_gating_get_src(
                  ^^^^^^
        struct of_phandle_args *clkspec, void *data)
{
        struct mvebu_gating_ctrl *ctrl = (struct mvebu_gating_ctrl *)data;

maybe?
