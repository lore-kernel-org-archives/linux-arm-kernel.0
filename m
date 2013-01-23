From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 Jan 2013 20:44:48 -0500
Subject: [PATCH 0/5] mmc: mvsdio: use devm_ API to simplify/correct
 error paths.
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130123014447.GE1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 02:13:55PM +0100, Andrew Lunn wrote:
> Russell King pointed out a number of issues with the probe code in the
> mvsdio driver and supplied a patch. This patchset uses a modified
> version, converting resource allocations to devm API calls, and fixes
> the error paths. The patches that then follow are from Thomas
> Petazzoni making other cleanups and adding device tree. These patches
> needed some changes after the swap to devm. The patches here replace
> the earlier submitted patches with the same Subject.
> 
> Andrew Lunn (1):
>   mmc: mvsdio: use devm_ API to simplify/correct error paths.

Applied to mvebu/fixes.

> Thomas Petazzoni (4):
>   mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
>   mmc: mvsdio: use slot-gpio for card detect gpio
>   mmc: mvsdio: implement a Device Tree binding
>   mmc: mvsdio: add pinctrl integration

Re-applied to mvebu/drivers

>  .../devicetree/bindings/mmc/orion-sdio.txt         |   17 ++
>  drivers/mmc/host/mvsdio.c                          |  187 ++++++++------------
>  2 files changed, 93 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt

thx,

Jason.
