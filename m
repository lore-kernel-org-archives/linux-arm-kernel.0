From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Dec 2017 11:13:59 -0800
Subject: [PATCH v4 0/4] add clk controller driver for Meson-AXG SoC
In-Reply-To: <20171201012452.27086-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Fri, 1 Dec 2017 09:24:48 +0800")
References: <20171201012452.27086-1-yixun.lan@amlogic.com>
Message-ID: <7hmv2vsm88.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> Add driver for the clk controller which found in Meson AXG SoC
>
>   Note, we deliberately create a seperate source file for the Meson AXG
> series, instead of sharing code with previous GXBB/GXL - the file axg.c
> It would help us maintaining the code more easily.

In addition to the DT node-name fixup (c.f. reply on v3 series), I think
this series should also include a patch that switches the UART over to
the new clock provider (it's currently using the xtal fixed clock.)

This will also provide a simple way to validate/test the series.

Kevin
