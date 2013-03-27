From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 27 Mar 2013 18:20:36 -0300
Subject: [PATCH v2 0/6] clk: sunxi: gates support
In-Reply-To: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the main sunxi gates; namely, those found 
on AXI, AHB, APB0 and APB1 clocks. The series depends on Maxime's UART 
rework and on the basic sunxi clock driver by me.

Patches 1 and 2 implement the actual gate support, and patch 3 switches 
the UARTs to use the correct gates now that they are available.

Patch 4 and 5 add clock support to our pinctrl driver, as we need to 
keep the pio clock running for gpio to work.

Patch 6 drops the ignore flags; now that we have actual clock users that 
will keep the important clocks running.

Patch 7 is an unrelated oneliner to remove an unnecesary kmalloc call.

The main changes from v1 are renamed compatible strings and a clarification
on the documentation, see each individual patch for more details.

Thanks,

Emilio

Emilio L?pez (7):
  clk: sunxi: Add support for AXI, AHB, APB0 and APB1 gates
  arm: sunxi: Add clock definitions for AXI, AHB, APB0, APB1 gates
  arm: sunxi: use the right clock phandles for UARTs
  pinctrl: sunxi: add clock support
  arm: sunxi: Add clock to pinctrl node
  clk: sunxi: drop CLK_IGNORE_UNUSED
  clk: sunxi: drop an unnecesary kmalloc
