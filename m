From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Apr 2012 14:26:04 +0200
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413012230.GA30438@windriver.com>
References: <20120413012230.GA30438@windriver.com>
Message-ID: <CACRpkdYkTHcppMtEy94cRiaHApeeohiiaCaA0SuyG52n1s+Yag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 3:22 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> is pointed at by git bisect for the u8500_defconfig build failure:
>
> drivers/dma/ste_dma40.c:2708:3: error: implicit declaration of function
> 'regulator_disable' [-Werror=implicit-function-declaration]
> drivers/dma/ste_dma40.c:2747:3: error: implicit declaration of function
> 'regulator_enable' [-Werror=implicit-function-declaration]
> drivers/dma/ste_dma40.c:3260:3: error: implicit declaration of function
> 'regulator_get' [-Werror=implicit-function-declaration]
> drivers/dma/ste_dma40.c:3271:4: error: implicit declaration of function
> 'regulator_put' [-Werror=implicit-function-declaration]

I've already sent a patch to the DMA maintainer to fix this.
It was a bug in the DMA driver actually - it did not include the proper
headers - so it just got triggered by this patch.
http://marc.info/?l=linux-kernel&m=133424730706377&w=2

Yours,
Linus Walleij
