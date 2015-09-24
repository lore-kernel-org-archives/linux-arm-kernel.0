From: davem@davemloft.net (David Miller)
Date: Thu, 24 Sep 2015 10:52:24 -0700 (PDT)
Subject: [PATCH net-next] net: Fix Hisilicon Network Subsystem Support
 Compilation
In-Reply-To: <1443088449-147241-1-git-send-email-huangdaode@hisilicon.com>
References: <1443088449-147241-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <20150924.105224.795981964968343044.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: huangdaode <huangdaode@hisilicon.com>
Date: Thu, 24 Sep 2015 17:54:09 +0800

> This patch fixes the compilation error with arm allmodconfig, this error
> generated due to unavailability of readq on 32-bit platform which was
> found during net-next daily compilation
> 
> Signed-off-by: huangdaode <huangdaode@hisilicon.com>
> Singed-off-by: yankejian <yankejian@huawei.com>

This is not necessaily the right fix, sorry.

I'd rather this driver be available to compile on as many
configurations as possible, to increase build coverage.

There is a standard way to make readq available on 32-bit platforms
and I want you to do research into how that works and how you can thus
make your driver build even on 32-bit targets.
