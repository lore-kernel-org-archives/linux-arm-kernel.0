From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 12:40:38 -0600
Subject: [PATCHv3 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
In-Reply-To: <20170106041517.9589-3-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-3-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170109184038.bz3oqyvtbua562pl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 05:14:59PM +1300, Chris Packham wrote:
> Compared to the armada-xp the 98DX3336 uses different registers to set
> the boot address for the secondary CPU so a new enable-method is needed.
> This will only work if the machine definition doesn't define an overall
> smp_ops because there is not currently a way of overriding this from the
> device tree if it is set in the machine definition.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>     Changes in v2:
>     - Document new enable-method value
>     - Correct some references from 98DX4521 to 98DX3236
>     
>     Changes in v3:
>     - Simplify mv98dx3236_resume_init by using of_io_request_and_map()
> 
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  | 18 ++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-mvebu/Makefile                       |  1 +
>  arch/arm/mach-mvebu/common.h                       |  1 +
>  arch/arm/mach-mvebu/platsmp.c                      | 43 ++++++++++++++++++
>  arch/arm/mach-mvebu/pmsu-98dx3236.c                | 52 ++++++++++++++++++++++
>  6 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
>  create mode 100644 arch/arm/mach-mvebu/pmsu-98dx3236.c
