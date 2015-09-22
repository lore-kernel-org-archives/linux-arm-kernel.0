From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Sep 2015 09:18:32 -0700
Subject: master build: 1 failures 68 warnings (v4.3-rc2-16-gac2fc4b)
In-Reply-To: <E1ZeICY-00014h-E8@optimist>
References: <E1ZeICY-00014h-E8@optimist>
Message-ID: <20150922161832.GH30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 08:41:25AM +0100, Build bot for Mark Brown wrote:

Mainline is still failing to build an arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before '__asmeq'
> ../drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function 'secure_flush_area' [-Werror=implicit-function-declaration]
> ../drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function 'outer_inv_range' [-Werror=implicit-function-declaration]
> ../drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before '__asmeq'
> ../drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before '__asmeq'

which has been the case since before -rc1.  There was a patch posted for
this by Andy Gross (firmware: qcom: scm: Add function stubs for ARM64)
which got positively reviewed - where are we with getting that merged
into mainline?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/53da9808/attachment.sig>
