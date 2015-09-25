From: davem@davemloft.net (David Miller)
Date: Fri, 25 Sep 2015 00:12:12 -0700 (PDT)
Subject: [PATCH v2] net: Fix Hisilicon Network Subsystem Support
 Compilation
In-Reply-To: <1443163643-112192-1-git-send-email-huangdaode@hisilicon.com>
References: <1443163643-112192-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <20150925.001212.866826387271637011.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: huangdaode <huangdaode@hisilicon.com>
Date: Fri, 25 Sep 2015 14:47:23 +0800

> @@ -966,7 +966,15 @@ static inline u32 dsaf_get_reg_field(void *base, u32 reg, u32 mask, u32 shift)
>  #define dsaf_read_b(addr)\
>  	readb((__iomem unsigned char *)(addr))
>  
> +#ifndef readq
> +static inline u64 readq(void __iomem *reg)
> +{

Nope, try instead "#include <asm/io-64-nonatomic-lo-hi.h" or
"#include <asm/io-64-nonatomic-hi-lo.h".
