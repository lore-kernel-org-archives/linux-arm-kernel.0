From: martin@sperl.org (Martin Sperl)
Date: Fri, 11 Sep 2015 12:24:50 +0200
Subject: [PATCH 2/3] clk: bcm2835: Add a driver for the auxiliary
 peripheral clock gates.
In-Reply-To: <1441923750-19404-3-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
 <1441923750-19404-3-git-send-email-eric@anholt.net>
Message-ID: <D051D944-F10B-460F-AF10-8C177A3A7E3D@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 11.09.2015, at 00:22, Eric Anholt <eric@anholt.net> wrote:
> 
> There are a pair of SPI masters and a mini UART that were last minute
> additions.  As a result, they didn't get integrated in the same way as
> the other gates off of the VPU clock in CPRMAN.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Tested with the spi-bcm2835aux driver and it works perfectly.
I will now post the latest incarnation of the driver for inclusion.

I have also tested with the uart1 and it works in principle.

Note that there is one issue (as mentioned elsewhere) with uart1:
the 8250 serial driver has a (hardcoded) internal clock divider 16,
while the hardware has an internal divider of 8.

This results in baud rates that are a factor of 2 higher than requested.

Tested-by: Martin Sperl <kernel@martin.sperl.org>
