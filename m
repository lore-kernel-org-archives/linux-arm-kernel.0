From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Aug 2012 17:29:23 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120820125531.GA20242@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
 <201208140942.54773.arnd@arndb.de>
 <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
 <20120820083640.GH8450@gmail.com>
 <20120820121055.GA26991@opensource.wolfsonmicro.com>
 <20120820125531.GA20242@gmail.com>
Message-ID: <20120820162923.GF26991@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 01:55:32PM +0100, Lee Jones wrote:

> Right, that was the initial intention. It would be a trivial semantic
> change if drivers without DT support wished to use the functionality
> though. However, the only examples I found of a non-DT enabled driver
> that could make good use of it in order to strip out some cruft would
> be the Arizona and one of the Samsung drivers, and they each have

All of the regmap devices could use this.

> their own hand-rolled methods of hwirq -> virq conversion now, so any
> change to support them would result in multiple invocations of
> irq_create_mapping which would likely cause breakage.

Multiple calls to irq_create_mapping() are totally fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120820/c6a761ac/attachment.sig>
