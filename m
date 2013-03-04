From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Mar 2013 17:22:49 +0100
Subject: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
In-Reply-To: <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
 <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <2835497.S76YK1KMLM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 March 2013 17:20:54 Bastian Hecht wrote:
> 
> +       sci at e6c40000 {
> +               compatible = "renesas,sci-SCIFA-uart";
> +               interrupt-parent = <&intca>;
> +               reg = <0xe6c40000 0x100>;
> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
> +               cell-index = <0>;
> +               renesas,scscr = <0x30>;
> +               renesas,scbrr-algo-id = <4>;
> +               renesas,autoconf;
> +       };

The default name for a uart is "serial", I would recommend sticking to
that by convention. You may also want to add an "aliases" node
somewhere, to define which port should get which logical device number
on a given board.

	Arnd
