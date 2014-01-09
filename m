From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 15:37:21 +0100
Subject: [linux-sunxi] Re: [PATCH v2 3/3] ARM: sun7i: irqchip: Update the
 documentation
In-Reply-To: <CAOQ7t2YYr_gphkXnp1OVsR_sHoOdEhVzDMETjJ2FsDz=Pvh7xQ@mail.gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
 <14122384.i9DNmsOzpC@wuerfel>
 <CAOQ7t2YYr_gphkXnp1OVsR_sHoOdEhVzDMETjJ2FsDz=Pvh7xQ@mail.gmail.com>
Message-ID: <201401091537.21584.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Carlo Caione wrote:
> In Allwinner A20/A31 SoCs NMI controller is an independent module
> external and in cascade with the GIC. It catches the NMI pin's state
> and generates irq to GIC.
> (therefore NMI is not really not Non-maskable but it is a normal interrupt).
> Here is an ascii-plot of the system (thanks to Maxime and the
> Allwinner engineers for this)
> 
>            +---------+            +-----------+
>            |         +------------+ FIQ       |
>            |   GIC   |            |           |
>            |         +------------+ INT   CPU |
>            +--+---+--+            |           |
>               |   |               |           |
>               |   +------+        |           |
>               |          |        |           |
>  +-----+   +--+--+   +---+---+    |           |
>  | AXP +-+-+ NMI +   | ALARM |    |           |
>  +-----+ | +-----+   +---+---+    +-----------+
>          |               |
>          +---------------+

Ah, cool. That certianly makes sense now. Thanks for the explanation.

	Arnd
