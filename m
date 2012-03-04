From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:47:53 -0800
Subject: [PATCH] ARM: dt: Explicitly configure all serial ports on Tegra
 Cardhu
In-Reply-To: <1328210659-16869-1-git-send-email-swarren@nvidia.com>
References: <1328210659-16869-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120304184753.GA32119@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 12:24:19PM -0700, Stephen Warren wrote:
> The ports are used as follows:
> UART1/A: Routed to debug dongle
> UART2/B: GPS
> UART3/C: Bluetooth
> UART4/D: Routed to debug dongle
> UART5/E: Not connected
> 
> The debug dongle has jumpers to connect either UART1/A or UART4/D to
> the DB-9 connector. UART1/A is typically used on Cardhu, and is the option
> we assume here.
> 
> For now, only enable UART1/A, and explicitly disable all other ports.
> 
> The explicit disable prevents the message "of_serial 70006040.serial:
> no clock-frequency property set" being printed during boot.
> 
> Enabling the other ports requires their clocks to be enabled, or accesses
> to the registers will hang. At present, this requires adding entries into
> board-dt-tegra30.c's tegra_dt_clk_init_table[]. Lets punt on that and wait
> for the common clock bindings to set this all up, although that will also
> requiring adding clock support to 8250.c.
> 
> While we're at it, fix board-dt-tegra30.c to enable the correct clock for
> the debug UART. We got away with this before, because the bootloader already
> enabled it.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.4/t30-smp (since it depends on other changes there).


-Olof
