From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Jun 2011 11:31:25 +0100
Subject: [PATCH 1/2] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <BANLkTin6hSaNSDd+dEZdkk3F5O5nDYf9yQ@mail.gmail.com>
References: <1308215372-17420-1-git-send-email-myungjoo.ham@samsung.com>
	<20110618151227.GB25163@sirena.org.uk>
	<BANLkTin6hSaNSDd+dEZdkk3F5O5nDYf9yQ@mail.gmail.com>
Message-ID: <20110620103124.GD31864@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 04:58:09PM +0900, MyungJoo Ham wrote:

> However, the MAX8997 driver uses platform_data's entry (variables
> defined in "static struct max8997_platform_data __initdata
> nuri_max8997_pdata)
> in its normal functions other than its probe function, which are often
> called after boot.

That's bad practice on its part.

> I just can't sure whether I should let probe function copy
> platform-data used by non-probe functions to its own local data

This is the best fix.
