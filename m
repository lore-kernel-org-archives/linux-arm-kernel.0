From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Thu, 30 Oct 2014 18:43:12 +0100
Subject: [PATCH 3/8] ARM: shmobile: r8a73a4: Add SCIF nodes
In-Reply-To: <94f1a03db6988c64601dc84eaf6c8ef1b956d9e7.1405398515.git.horms+renesas@verge.net.au>
References: <cover.1405398515.git.horms+renesas@verge.net.au>
 <94f1a03db6988c64601dc84eaf6c8ef1b956d9e7.1405398515.git.horms+renesas@verge.net.au>
Message-ID: <CAO3366zufRM-2+ezcKODYD29iuyQjwbjOE3bo5=D9Q+HcZS0TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Jul 15, 2014 at 11:16 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This describes all of the SCIF hardware of the r8a73a4.
> Each node is disabled and may be enabled as necessary
> by board DTS files.
[...]
> +       scifb2: serial at e6c20000 {
> +               compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
> +               reg = <0 0xe6c20000 0 0x100>;
> +               interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
> +               status = "disabled";
> +       };
> +
> +       scifb3: serial at e6c30000 {
> +               compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
> +               reg = <0 0xe6c30000 0 0x100>;
> +               interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
> +               status = "disabled";
> +       };
> +
> +       scifb4: serial at e6ce0000 {
> +               compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
> +               reg = <0 0xe6ce0000 0 0x100>;
> +               interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
> +               status = "disabled";
> +       };
> +
> +       scifb5: serial at e6cf0000 {
> +               compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
> +               reg = <0 0xe6cf0000 0 0x100>;
> +               interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
> +               status = "disabled";
> +       };
> +

I was just about to add clocks to these devices when I noticed that
these ports are labeled scifb0 to scifb3 in the datasheet. Is there
any deeper reasoning behind this, or did you just forget to reset the
counter after scifa1? :)

CU
Uli
