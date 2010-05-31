From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 31 May 2010 10:44:09 +0100
Subject: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <AANLkTimJyc8E_D_-95eeVFwOVXwJKM5xKCCW-7gkNWrU@mail.gmail.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<201005300542.37715.marek.vasut@gmail.com>
	<AANLkTilt_-UAZGZepwtIYM7HRuPsX7gsW_ppLZD1_bZq@mail.gmail.com>
	<20100530045151.GE4720@trinity.fluff.org>
	<AANLkTimJyc8E_D_-95eeVFwOVXwJKM5xKCCW-7gkNWrU@mail.gmail.com>
Message-ID: <20100531094408.GB7799@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 30, 2010 at 02:04:39PM +0900, Jassi Brar wrote:

> I believe on most implementations, if not all, sizeof char, short and
> int are resp
> 1, 2 and 4 bytes. whereas long denotes the native capacity of the arch.

This is very common for interoperability with code making the assumption
that you just made but you shouldn't rely on it, the C standard just
specifies minimum sizes and requires that char <= short <= int <= long.
The common issues to run into are int being made the native word size
and not having any sub word types@all.
