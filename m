From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jul 2015 13:44:10 +0100
Subject: next-20150729 build: 2 failures 49 warnings (next-20150729)
In-Reply-To: <E1ZKPJk-0007VU-Fg@optimist>
References: <E1ZKPJk-0007VU-Fg@optimist>
Message-ID: <20150729124410.GE20130@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 12:14:36PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../include/linux/platform_device.h:245:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
> ../include/linux/platform_device.h:250:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]

caused by c84e358718a66f76 (soc: Mediatek: Add SCPSYS power domain
driver) which does not include module.h.  Arguably platform_device.h
should do that, though it's only an issue if the macro is used so...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/aa3fc529/attachment.sig>
