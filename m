From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:33:32 -0400
Subject: [PATCH] ARM: mvebu: Fix broken SoC ID detection
In-Reply-To: <1402347165-19988-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1402347165-19988-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140620203332.GI21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 05:52:45PM -0300, Ezequiel Garcia wrote:
> Currently the mvebu boards need to detect the SoC revision in order to apply
> some quirks needed to workaround issues found on I2C and thermal controllers
> present only in very early SoC.
> 
> This detection requires PCI address translation to work, so we need to
> explicitly select OF_ADDRESS_PCI.
> 
> This can be considered a partial revert of the following commit, that
> wrongly removed the option selection:
> 
> commit 55400f3a1f89e39761f45c19f6e4235a329c400b
> Author: Rob Herring <robh@kernel.org>
> Date:   Tue Apr 22 14:15:52 2014 -0500
> 
>     ARM: mvebu: clean-up unneeded kconfig selects
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes with Rob's Ack.

thx,

Jason.
