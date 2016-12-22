From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Dec 2016 16:47:04 -0600
Subject: [PATCH 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
In-Reply-To: <20161222041328.3303-3-chris.packham@alliedtelesis.co.nz>
References: <20161222041328.3303-1-chris.packham@alliedtelesis.co.nz>
 <20161222041328.3303-3-chris.packham@alliedtelesis.co.nz>
Message-ID: <20161222224704.6ikncsvb76y4zmfe@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 05:13:25PM +1300, Chris Packham wrote:
> Compared to the armada-xp the 98DX3336 uses different registers to set
> the boot address for the secondary CPU so a new enable-method is needed.
> This will only work if the machine definition doesn't define an overall
> smp_ops because there is not currently a way of overriding this from the
> device tree if it is set in the machine definition.

Doesn't look like you documented the enable-method value.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  | 18 ++++++
>  arch/arm/mach-mvebu/Makefile                       |  1 +
>  arch/arm/mach-mvebu/common.h                       |  1 +
>  arch/arm/mach-mvebu/platsmp.c                      | 43 ++++++++++++++
>  arch/arm/mach-mvebu/pmsu-98dx3236.c                | 69 ++++++++++++++++++++++
>  5 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>  create mode 100644 arch/arm/mach-mvebu/pmsu-98dx3236.c
