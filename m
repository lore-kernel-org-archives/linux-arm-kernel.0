From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Jul 2012 18:46:52 +0200
Subject: [PATCH v2 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <1343749529-17571-4-git-send-email-ian.molton@codethink.co.uk>
References: <1343749529-17571-1-git-send-email-ian.molton@codethink.co.uk>
 <1343749529-17571-4-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <20120731164652.GD28852@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 04:45:26PM +0100, Ian Molton wrote:
> This patch adds basic device tree support to the mv643xx ethernet driver.
> 
> It should be enough for most current users of the device, and should allow
> a fairly painless migration once proper support for clk devices is available
> to those platforms.
> 
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  Documentation/devicetree/bindings/net/mv643xx.txt |   75 +++++++++++++
>  arch/arm/mach-kirkwood/board-dt.c                 |    5 +

Hi Ian

Probably the driver change will get upstream by netdev. The rest will
go via the Orion maintainers into arm-soc. So you should probably move
this board-dt.c change into a patch of its own, or make it part of:

csb1724: Enable device tree based mv643xx ethernet support.

	 Thanks
		Andrew
