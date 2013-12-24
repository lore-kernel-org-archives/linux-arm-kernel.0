From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 12:24:55 +0000
Subject: [RFC 10/18] regulator: vexpress: Use regmap instead of custom
 interface
In-Reply-To: <1387815830-8794-11-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-11-git-send-email-pawel.moll@arm.com>
Message-ID: <20131224122455.GY30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 04:23:42PM +0000, Pawel Moll wrote:

> This patch makes the Versatile Express regulator driver
> use regmap interface, instead of custom vexpress config
> one. It will request the regmap resource associated
> with the device, which makes it pretty much hardware
> agnostic.

If this change is making the operations hardware agnostic regmap based
ones then they should be being either replaced with standard operations
or standard operations being added.  It looks like you should be able to
use the existing linear map operations.
