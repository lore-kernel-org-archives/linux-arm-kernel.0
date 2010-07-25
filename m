From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Sun, 25 Jul 2010 12:34:22 -0600
Subject: [PATCH 6/7] save and restore etm state across core OFF modes
In-Reply-To: <1280077520-7538-7-git-send-email-virtuoso@slind.org>
References: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
	<1280077520-7538-7-git-send-email-virtuoso@slind.org>
Message-ID: <AANLkTinmSJ6dtgqmyuk9CArniPEvEp7TrXauvGxLxv7x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +config ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> + ? ? ? bool "Enable hardware emulation context save and restore"
> + ? ? ? depends on ARCH_OMAP3

-- Shouldn't this be depends on OMAP3_EMU instead ?

> + ? ? ? default y

-- As this is debug option, can you keep this "n" by default ?

> + ? ? ? help
> + ? ? ? ? This option enables JTAG & ETM debugging across power states.
> + ? ? ? ? With out this option emulation features are reset across OFF
> + ? ? ? ? mode state changes.
> +

Hari
