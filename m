From: zonque@gmail.com (Daniel Mack)
Date: Tue, 17 Jul 2012 15:30:24 +0200
Subject: [PATCH 0/3 V2] Initial PXA DT bindings
In-Reply-To: <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <500568F0.8000202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.11.2011 22:31, Marek Vasut wrote:
> This patchset starts effort to convert PXA machines to DT. I started with PXA
> UART driver and added a stub machine, which I plan to eventually rename to
> board-pxa-dt when ready.
> 
> The file in patch 0002 contains style errors (line over 80), because they are 1
> character over. To avoid crippling readability, I left that as is.
> 
> Marek Vasut (3):
>   ARM: pxa: Add DT support to pxa2xx-uart
>   ARM: pxa: Add DT testing machine
>   ARM: pxa: Add basic DTS files for PXA/Vpac270 testing machine
> 
>  arch/arm/boot/dts/pxa-vpac270.dts |   37 +++++++++++++++++
>  arch/arm/boot/dts/pxa.dtsi        |   71 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/Kconfig         |   15 +++++++
>  arch/arm/mach-pxa/Makefile        |    3 +
>  arch/arm/mach-pxa/vpac270-dt.c    |   82 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/vpac270.c       |    2 +
>  drivers/tty/serial/pxa.c          |   46 +++++++++++++++++++-
>  7 files changed, 253 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/pxa-vpac270.dts
>  create mode 100644 arch/arm/boot/dts/pxa.dtsi
>  create mode 100644 arch/arm/mach-pxa/vpac270-dt.c

I wonder what happend to this patch series. I can't seem to find the
patches in mainline, although it's more than 8 months ago when they were
discussed. And I can't see any reason for rejecting them in the thread
either.

I'd like to extend the support to PXA3xx chips and get rid of some board
files in favour of DT. One uncertainty I have about that is clock
handling. What's a good migration path to get those bits moved over?
>From what I can see, when probed solely from the device tree, device
names default to their base address, and the dev_id is a globally
incrementing counter. Are platforms supposed to provide clock aliases in
that form?


Daniel
