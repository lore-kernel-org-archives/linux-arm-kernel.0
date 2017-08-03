From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 Aug 2017 09:26:54 +0800
Subject: [PATCH v5 0/8] Add board support for TS-4600
In-Reply-To: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20170803012652.GB31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 04:32:10PM -0400, Sebastien Bourdelin wrote:
> This patch serie adds support for the TS-4600 boards rev A and B. These
> boards, manufactured by Technologic Systems, are based on an i.MX28.
> 
> This serie include the support for the watchdog which could be enable
> at Linux boot time depending on the bootloader.
> 
> The watchdog and few peripherals are implemented in a FPGA, and can
> only be access using a custom GPIOs bit-banged bus which is called the
> NBUS by Technologic Systems.
> A driver for this bus is also included and used by the watchdog.
> 
> Sebastien Bourdelin (8):
>   of: documentation: add bindings documentation for TS-4600
>   ARM: dts: TS-4600: add basic device tree
>   dt-bindings: bus: Add documentation for the Technologic Systems NBUS
>   bus: add driver for the Technologic Systems NBUS
>   ARM: dts: TS-4600: add NBUS support
>   dt-bindings: watchdog: add documentation for TS4600 watchdog
>     controller
>   watchdog: TS-4600: add driver for TS-4600 watchdog controller
>   ARM: dts: TS-4600: add watchdog support

You are mixing changes on 3 subsystem in a single patch series.  It
makes the merge process unnecessarily hard.  I suggest you split the
series as following:

 - nbus dt-bindings and driver
 - watchdog dt-bindings and driver
 - ts-4600 board bindings and dts

You should get the first two into mainline through corresponding
subsystem tree, and then submit the last one to me.  In that case, NBUS
and watchdog dts changes do not have to be separate patches.

Shawn
