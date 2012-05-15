From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 12:31:46 +0100
Subject: [PATCH 3/8] arm: mach-armada: add documentation for new device
 tree bindings
In-Reply-To: <1337072084-21967-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FB23EA2.3040109@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 09:54, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
> ---
>   .../devicetree/bindings/arm/armada-mpic.txt        |   23 +++++++++++++++++++
>   .../devicetree/bindings/arm/armada-timer.txt       |   11 +++++++++
>   Documentation/devicetree/bindings/arm/armada.txt   |   24 ++++++++++++++++++++
>   3 files changed, 58 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/armada-mpic.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/armada-timer.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/armada.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/armada-mpic.txt b/Documentation/devicetree/bindings/arm/armada-mpic.txt
> new file mode 100644
> index 0000000..3571f44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/armada-mpic.txt
> @@ -0,0 +1,23 @@
> +Marvell Armada Interrupt Controller
> +-----------------------------------
> +
> +Required properties:
> +- compatible: Should be "marvell,mpic"

see notes on mrvl, and the usage of very generic names. Maybe find a
better name than the generic 'mpic'?

> +- interrupt-controller: Identifies the node as an interrupt controller.
> +- #interrupt-cells: The number of cells to define the interrupts. Should be 1.
> +  The cell is the IRQ number
> +- reg: Should contain PMIC registers location and length. First pair
> +  for the main interrupt registers, second pair for the per-CPU
> +  interrupt registers

you mis-spelled MPIC as PMIC.

> diff --git a/Documentation/devicetree/bindings/arm/armada-timer.txt b/Documentation/devicetree/bindings/arm/armada-timer.txt
> new file mode 100644
> index 0000000..6bed565
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/armada-timer.txt
> @@ -0,0 +1,11 @@
> +Marvell Armada Global Timers
> +----------------------------
> +
> +Required properties:
> +- compatible: Should be "marvell,timer"
> +- interrupts: Should contain the list of Global Timer interrupts
> +- reg: Should contain the base address of the Global Timer registers

I'd say that given you already have a clock-frequency field, just use
that and detect == 25MHz.

Personally, I would have added a static clock to give to the timer
something to reference.

> +Optional properties:
> +- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
> +  Mhz fixed mode (available on Armada XP and not on Armada 370)

See above comment.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
