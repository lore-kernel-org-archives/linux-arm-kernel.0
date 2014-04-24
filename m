From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Apr 2014 00:51:53 -0400
Subject: [RESEND/PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140424045153.GU28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 10:23:24AM -0300, Ezequiel Garcia wrote:
> Here's the fourth round of the patchset adding support for watchdog
> on Armada 375 and Armada 38x SoCs, rebased on v3.15-rc1 and with
> collected Tested-by's.
> 
> The new Armada 375/385 SoCs have two registers for the watchdog RSTOUT:
> 
>  1. It has a dedicated register (similar to the one in A370/XP)
>  2. Also has a bit in a shared RSTOUT register.
> 
> Therefore, in order to support this two-folded RSTOUT, we extend the 'reg'
> property in the watchdog devicetree and require a new pair of cells to specify
> the shared RSTOUT.
> 
> On the driver side, we need to implement per-SoC stop() and enabled()
> functions. Such somewhat complex infrastructure is needed to ensure the driver
> performs proper reset of the watchdog timer, by masking and disabling the
> RSTOUT before the interrupt is enabled.
> 
> Tested on A375-DB, A385-DB, A370-RD and Dove Cubox. Sebastian did more tests
> on Dove, and Jason Gunthorpe on Kirkwood.

Applied patches 7 and 8 to mvebu/dt.  For the rest,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
