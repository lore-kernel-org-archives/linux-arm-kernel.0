From: dhdang@apm.com (Duc Dang)
Date: Fri, 19 Feb 2016 12:43:34 -0800
Subject: [PATCH v6 0/3] mailbox: Add APM X-Gene platform mailbox driver
In-Reply-To: <cover.1455333720.git.dhdang@apm.com>
References: <CANLsYkxPnFCuJLyKsHnXKdbvAwNurtgQgJ-WF+bD26+8EjkfJw@mail.gmail.com>
 <cover.1455333720.git.dhdang@apm.com>
Message-ID: <CADaLND=7W9YQwKjMA1BR-PuncYEnKOcQyR6xLbEvig2qgKryqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 7:39 PM, Duc Dang <dhdang@apm.com> wrote:
> APM X-Gene SoC has a mailbox controller that provides
> communication mechanism for X-Gene Arm64 cores to communicate
> with X-Gene SoC's Cortex M3 (SLIMpro) processor.
>
> X-Gene mailbox controller provides 8 mailbox channels, with
> each channel has a dedicated interrupt line.

Hi Jassi,

Are you fine with this version of the patch?

Regards,
Duc Dang.
>
> Changes since v5:
>         - Add more description into SlimPRO
>         mailbox data structure
>
> Changes since v4:
>         - Rebase over v4.5-rc1
>         - Fix section mismatch warning during compiling
>         - Correctly print channel number when there is
>         no IRQ for that channel
>         - Change node name to mailbox at 10540000
>         - Correct the number of IRQs in documentation
>
> Changes since v3:
>         - Rebase over v4.4
>         - Remove 'id' in slimpro_mbox_chan structure
>         - Remove functions that are only called once
>         and fold them into the other callers
>         - Remove void* pointer type cast
>         - Relax the number of mailbox IRQs condition
>         - Fix error and address comment in documentation
>         (xgene-slimpro-mailbox.txt)
>
> Changes since v2:
>         - Rebase Feng's patch set over v4.3-rc5
>         - Remove uneccessary 'inline' in function definition
>         - Use module_platform_driver instead of subsys_initcall
>         - Minor coding stype clean up
>
> Changes since v1:
>         - Add ACPI support
>         - Use defines for reg offset
>
> Duc Dang (3):
>   mailbox: Add support for APM X-Gene platform mailbox driver
>   Documentation: mailbox: Add APM X-Gene SLIMpro mailbox dts
>     documentation
>   arm64: dts: mailbox device tree node for APM X-Gene platform.
>
>  .../bindings/mailbox/xgene-slimpro-mailbox.txt     |  35 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi             |  14 +
>  drivers/mailbox/Kconfig                            |   9 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/mailbox-xgene-slimpro.c            | 284 +++++++++++++++++++++
>  5 files changed, 344 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
>  create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c
>
> --
> 1.9.1
>
