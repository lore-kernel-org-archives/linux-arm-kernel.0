From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 20:56:40 -0500
Subject: [PATCH v7 0/4] DT support for kirkwood based Synology NAS boxes
In-Reply-To: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
References: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <20140222015640.GS7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

On Thu, Feb 20, 2014 at 06:02:33AM +1000, klightspeed at killerwolves.net wrote:
> This patchset adds support for around 30 kirkwood bases Synology NAS
> boxes. Patch #1 documents vendor prefixes. Patch #2 generalizes the qnap
> power off driver so that it can also be used for Synology devices.
> Patch #3 adds sii,s35390a to i2c trivial devices. Patch #4 adds the 
> synology DT files.
...
> Andrew Lunn (3):
>   DT: Vendor prefixes: Add ricoh, qnap, sii and synology
>   Power: Reset: Generalize qnap-poweroff to with on Synology devices.
>   DT: i2c: Trivial: Add sii,s35390a
> 
> Ben Peddell (1):
>   ARM: Kirkwood: Add support for many Synology NAS devices
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  .../bindings/power_supply/qnap-poweroff.txt        |   5 +-
>  .../devicetree/bindings/vendor-prefixes.txt        |   4 +
>  arch/arm/boot/dts/Makefile                         |  15 +
>  arch/arm/boot/dts/kirkwood-ds109.dts               |  41 +
>  arch/arm/boot/dts/kirkwood-ds110jv10.dts           |  41 +
>  arch/arm/boot/dts/kirkwood-ds111.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-ds112.dts               |  48 ++
>  arch/arm/boot/dts/kirkwood-ds209.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-ds210.dts               |  46 ++
>  arch/arm/boot/dts/kirkwood-ds212.dts               |  47 ++
>  arch/arm/boot/dts/kirkwood-ds212j.dts              |  41 +
>  arch/arm/boot/dts/kirkwood-ds409.dts               |  48 ++
>  arch/arm/boot/dts/kirkwood-ds409slim.dts           |  40 +
>  arch/arm/boot/dts/kirkwood-ds411.dts               |  52 ++
>  arch/arm/boot/dts/kirkwood-ds411j.dts              |  48 ++
>  arch/arm/boot/dts/kirkwood-ds411slim.dts           |  48 ++
>  arch/arm/boot/dts/kirkwood-rs212.dts               |  48 ++
>  arch/arm/boot/dts/kirkwood-rs409.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-rs411.dts               |  44 ++
>  arch/arm/boot/dts/kirkwood-synology.dtsi           | 871 +++++++++++++++++++++
>  drivers/power/reset/qnap-poweroff.c                |  49 +-
>  22 files changed, 1656 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-synology.dtsi

I applied patches 1, 3, and 4 to mvebu/dt.

Thanks and good work!

Jason.
