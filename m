From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:01:51 +0100
Subject: master build: 1 failures 73 warnings (v4.2-11142-gb0a1ea5)
In-Reply-To: <E1ZaL9B-0006QE-Kh@optimist>
References: <E1ZaL9B-0006QE-Kh@optimist>
Message-ID: <20150911120150.GN12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 11:01:35AM +0100, Build bot for Mark Brown wrote:

> 	arm64-allmodconfig
> ../drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before '__asmeq'
> ../drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function 'secure_flush_area' [-Werror=implicit-function-declaration]
> ../drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function 'outer_inv_range' [-Werror=implicit-function-declaration]
> ../drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before '__asmeq'
> ../drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before '__asmeq'

Today's mainline fails to build on arm64 due to the above, introduced by
efaa6e266ba (firmware: qcom_scm-32: replace open-coded call to
__cpuc_flush_dcache_area()) which introduces a call to
secure_flush_area() which isn't defined on arm64.  This does not happen
in -next as 626ffb400e1e781 (firmware: qcom: scm: Add function stubs for
ARM64) which fixes this and IIRC other issues on arm64 - what is the
plan for getting that change into mainline?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/b2ab4134/attachment.sig>
