From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 9 May 2017 09:24:20 -0700
Subject: [PATCH] PCI: imx6: remove LTSSM disable workaround
In-Reply-To: <20170120155837.2874-1-l.stach@pengutronix.de>
References: <20170120155837.2874-1-l.stach@pengutronix.de>
Message-ID: <CAJ+vNU1LqNRNEEX4NH3uyiw-xS-07zU94drhGOewwYM5UOs87Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 7:58 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This causes CPU hangs when the system is reset by the watchdog, as
> the GPRs aren't cleared, but the clocks are back to disabled state.
>
> If the bootloader uses PCIe, it must take care to bring it down
> into a safe state, before passing control to the Linux kernel.
> This is the only way to get a properly operating system at all
> times and circumstances.
>

Lucas,

I missed this patch when it came through.

Can you give some details about what you consider a 'safe state' for
the bootloader to bring PCI to before passing control to the kernel
(with respect to PERST#, PCI CLK, and the various host controller
registers)? I would like to investigate making PCI available in the
bootloader as well as the kernel reliable on IMX6.

Regards,

Tim
