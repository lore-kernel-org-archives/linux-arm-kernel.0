From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 02 Sep 2016 16:34:43 -0700
Subject: [PATCH v2 0/3] Add Platform MHU mailbox driver for Amlogic GXBB
In-Reply-To: <1471515027-3543-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 18 Aug 2016 12:10:24 +0200")
References: <1471515027-3543-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m24m5xc1v0.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to support Mailbox links for the Amlogic GXBB SoC, add a generic
> platform MHU driver based on arm_mhu.c.
>
> This patchset follows a RFC thread along the GXBB SCPI support at :
> http://lkml.kernel.org/r/1466503374-28841-1-git-send-email-narmstrong at baylibre.com
> And specific MHU discussions at :
> http://lkml.kernel.org/r/CABb+yY3HqJG2+GMWCWF9PomxobrwWGZ=TZe5NvXPcHMDdLhkcQ at mail.gmail.com
>
> Changes since v1 at http://lkml.kernel.org/r/1470732737-18391-1-git-send-email-narmstrong at baylibre.com :
>  - Fix irq to signed to detect platform_get_irq() failures
>  - Introduced back the secure channel
>  - Fixed indexes

How is this version looking to you?

With your review/ack on the driver, I'd be happy to take it via the
amlogic tree as there shouldn't be any conflicts with your tree.

Kevin

> Changes since RFC v2 :
>  - Rename to platform_mhu
>  - Sync all link functions with arm_mhu
>
> Neil Armstrong (3):
>   mailbox: Add Platform Message-Handling-Unit variant driver
>   dt-bindings: mailbox: Add Amlogic Meson MHU Bindings
>   ARM64: dts: meson-gxbb: Add Meson MHU Node
>
>  .../devicetree/bindings/mailbox/meson-mhu.txt      |  34 ++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   9 +
>  drivers/mailbox/Kconfig                            |  10 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/platform_mhu.c                     | 205 +++++++++++++++++++++
>  5 files changed, 260 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
>  create mode 100644 drivers/mailbox/platform_mhu.c
