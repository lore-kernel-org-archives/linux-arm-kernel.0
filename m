From: agross@codeaurora.org (Andy Gross)
Date: Tue, 13 Oct 2015 14:49:32 -0500
Subject: [PATCH] firmware: qcom-scm: build for correct architecture level
In-Reply-To: <8346311.PtPZJEII3N@wuerfel>
References: <8346311.PtPZJEII3N@wuerfel>
Message-ID: <20151013194932.GB7212@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 04:56:19PM +0200, Arnd Bergmann wrote:
> The ".arch_extension sec" directive is only available on ARMv6 or higher,
> so if we enable the SCM driver while building a kernel for an older CPU,
> we get a build error:
> 
> /tmp/ccUyhMOY.s:130: Error: selected processor does not support ARM mode `smc #0'
> /tmp/ccUyhMOY.s:216: Error: selected processor does not support ARM mode `smc #0'
> /tmp/ccUyhMOY.s:373: Error: selected processor does not support ARM mode `smc #0'
> make[4]: *** [drivers/firmware/qcom_scm-32.o] Error 1
> 
> This changes the Makefile so we pass the ARMv7 architecture level both
> for the check and for the actual compilation of the scm driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks for fixing this.  I'll pull it in.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
