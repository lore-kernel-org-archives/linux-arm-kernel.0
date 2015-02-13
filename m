From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Feb 2015 18:31:21 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150213173121.GG26475@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 05:42:54PM +0100, Antoine Tenart wrote:
> Hi,
> 
> Marvell Berlin SoCs have a chip control register set providing several
> individual registers dealing with various controllers (pinctrl, reset,
> clk). This chip controller is described by a single DT node since the
> individual registers are spread among the chip control register bank.
> 
> Marvell Berlin also have a system control register set providing several
> individual registers for pinctrl or adc.
> 
> A series was sent[1] to correctly handle these two nodes, by introducing
> a Berlin mfd controller driver. The series converted the existing
> pin-controller and reset drivers to take the changes into account.

Hi Antoine

Something which needs to be discussed for both this patchset and the
previous one, is backwards compatibility of the device tree.

As far as i can see, these changes are not backwards compatible.
Somebody trying to boot a new kernel with a old DT blob is going to
have trouble.

How do we want to handle this?

    Andrew
