From: fkan@apm.com (Feng Kan)
Date: Tue, 18 Mar 2014 16:59:13 -0700
Subject: [PATCH V5 0/5] Add X-Gene platform reboot mechanism
In-Reply-To: <1391040198-14185-1-git-send-email-fkan@apm.com>
References: <1391040198-14185-1-git-send-email-fkan@apm.com>
Message-ID: <CAL85gmA=7auR3_=8J7FZctU=uiu+z0ZzNNC7XhZ2hGwW2aW9oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just want to ping this again, since no activity for a while. I have
added endian and
access size related information in the documentation.  Please let me
know if more is
needed.

On Wed, Jan 29, 2014 at 4:03 PM, Feng Kan <fkan@apm.com> wrote:
> Enable reboot driver for the X-Gene platform. Add generic syscon reboot
> driver.
>
> V5 Change:
>         - Documentation update, endian and access size.
>
> V4 Change:
>         - Remove old X-Gene reboot driver
>         - Add generic syscon reboot driver
>         - Add DTS and Kconfig for X-Gene reboot using syscon method
>
> V3 Change:
>         - Remove the reboot driver's use of acpi resource patch.
>         - Change the reboot driver to use syscon to parse out
>           system clock register. Remove the old method of getting
>           register from the reboot driver directly.
>         - Remove documentation since its now simple.
>
> V2 Change:
>         - Add support for using ACPI resource.
>
> Feng Kan (5):
>   power: reset: Add generic SYSCON register mapped reset
>   power: reset: Remove X-Gene reboot driver
>   arm64: dts: Add X-Gene reboot driver dts node
>   arm64: Select reboot driver for X-Gene platform
>   Documentation: power: reset: Add documentation for generic SYSCON
>     reboot driver
>
>  .../bindings/power/reset/syscon-reboot.txt         |   23 +++++
>  arch/arm64/Kconfig                                 |    2 +
>  arch/arm64/boot/dts/apm-storm.dtsi                 |   13 +++
>  drivers/power/reset/Kconfig                        |    8 +-
>  drivers/power/reset/Makefile                       |    2 +-
>  drivers/power/reset/syscon-reboot.c                |  100 +++++++++++++++++++
>  drivers/power/reset/xgene-reboot.c                 |  103 --------------------
>  7 files changed, 143 insertions(+), 108 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
>  create mode 100644 drivers/power/reset/syscon-reboot.c
>  delete mode 100644 drivers/power/reset/xgene-reboot.c
>
> --
> 1.7.6.1
>
