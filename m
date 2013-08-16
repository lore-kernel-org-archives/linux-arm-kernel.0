From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 16 Aug 2013 14:04:22 -0500
Subject: [PATCH RFC 1/3] spmi: Linux driver framework for SPMI
In-Reply-To: <02deef1d90121011ab1df90ad704ef0ee36e2584.1376596224.git.joshc@codeaurora.org>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <02deef1d90121011ab1df90ad704ef0ee36e2584.1376596224.git.joshc@codeaurora.org>
Message-ID: <1E157BCF-C34F-4839-AFE0-CBECA828B221@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 9, 2013, at 3:37 PM, Josh Cartwright wrote:

> From: Kenneth Heitke <kheitke@codeaurora.org>
> 
> System Power Management Interface (SPMI) is a specification
> developed by the MIPI (Mobile Industry Process Interface) Alliance
> optimized for the real time control of Power Management ICs (PMIC).
> 
> SPMI is a two-wire serial interface that supports up to 4 master
> devices and up to 16 logical slaves.
> 
> The framework supports message APIs, multiple busses (1 controller
> per bus) and multiple clients/slave devices per controller.
> 
> Signed-off-by: Kenneth Heitke <kheitke@codeaurora.org>
> Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
> drivers/Kconfig                 |   2 +
> drivers/Makefile                |   1 +
> drivers/of/Kconfig              |   6 +
> drivers/of/Makefile             |   1 +
> drivers/of/of_spmi.c            |  74 +++++
> drivers/spmi/Kconfig            |   9 +
> drivers/spmi/Makefile           |   7 +
> drivers/spmi/spmi-dbgfs.c       | 591 ++++++++++++++++++++++++++++++++++++++++
> drivers/spmi/spmi-dbgfs.h       |  37 +++
> drivers/spmi/spmi.c             | 449 ++++++++++++++++++++++++++++++
> include/linux/mod_devicetable.h |   8 +
> include/linux/of_spmi.h         |  37 +++
> include/linux/spmi.h            | 337 +++++++++++++++++++++++
> 13 files changed, 1559 insertions(+)
> create mode 100644 drivers/of/of_spmi.c
> create mode 100644 drivers/spmi/Kconfig
> create mode 100644 drivers/spmi/Makefile
> create mode 100644 drivers/spmi/spmi-dbgfs.c
> create mode 100644 drivers/spmi/spmi-dbgfs.h
> create mode 100644 drivers/spmi/spmi.c
> create mode 100644 include/linux/of_spmi.h
> create mode 100644 include/linux/spmi.h

Looks like you are missing a patch for the general OF binding for SPMI

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
