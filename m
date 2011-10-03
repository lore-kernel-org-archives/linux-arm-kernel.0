From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 15:40:24 +0100
Subject: [PATCH v3] ASoC: samsung: wm8994 depends on mfd_wm8994
In-Reply-To: <1373438.oHCphrxVRr@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<11174515.ANsqIhx0NX@wuerfel>
	<20111003140824.GM3731@opensource.wolfsonmicro.com>
	<1373438.oHCphrxVRr@wuerfel>
Message-ID: <20111003144023.GO3731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 04:35:46PM +0200, Arnd Bergmann wrote:

> I'm still confused, I thought you had NAKed the patch that selects the
> core because it ignores the dependencies. Here comes another variant,
> this time for your branch, and selecting the MFD driver directly while
> respecting its dependencies.

The problem with that one was that you had the select on the Kconfig for
the CODEC driver rather than on the machine drivers so you ended up with
the select being done from a symbol that is itself selected.

Applied this version, thanks.
