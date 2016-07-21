From: geoff@infradead.org (Geoff Levand)
Date: Thu, 21 Jul 2016 14:49:36 -0700
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <5790A902.6070601@arm.com>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
Message-ID: <1469137776.2977.128.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-07-21 at 11:50 +0100, Robin Murphy wrote:
> The Exynos UART (drivers/tty/serial/samsung.c) is one which comes to
> mind as definitely existing, and on arm64 systems to boot. The TX
> register is at offset 0x20 there.

Here's what I came up with.


+	struct data {const char *name; int tx_offset;};
+	static const struct data ok_list[] = {
+	/*	{"armada-3700-uart", ?},	*/
+		{"exynos4210-uart", 0x20},
+	/*	{"ls1021a-lpuart", ?},		*/
+	/*	{"meson-uart", ?},		*/
+	/*	{"mt6577-uart", ?},		*/
+		{"ns16550", 0},
+		{"ns16550a", 0},
+		{"pl011", 0},
+		{NULL, 0}
+	};
