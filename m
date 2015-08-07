From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 13:23:44 +0100
Subject: next-20150807 build: 2 failures 51 warnings (next-20150807)
In-Reply-To: <E1ZNgYS-0000SE-QL@optimist>
References: <E1ZNgYS-0000SE-QL@optimist>
Message-ID: <20150807122344.GT20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 01:15:20PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an arm64 allmodconfig with:

> 	arm64-allmodconfig
> ../drivers/firmware/qcom_scm-32.c:27:28: fatal error: asm/outercache.h: No such file or directory

This header file only exists on ARM, either the driver shouldn't be
built for ARMv8, we need a dummy header for ARMv8 or we need to use the
header conditionally in the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/4e390095/attachment.sig>
