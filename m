From: davem@davemloft.net (David Miller)
Date: Mon, 30 Nov 2015 14:50:57 -0500 (EST)
Subject: [PATCH V5 net-next 1/5] net:hns: Add support of Hip06 SoC to
 the Hislicon Network Subsystem
In-Reply-To: <1448522050-5576-2-git-send-email-salil.mehta@huawei.com>
References: <1448522050-5576-1-git-send-email-salil.mehta@huawei.com>
 <1448522050-5576-2-git-send-email-salil.mehta@huawei.com>
Message-ID: <20151130.145057.216796732457000987.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Thu, 26 Nov 2015 07:14:06 +0000

> -#define ENABLE		(0x1)
> -#define DISABLE		(0x0)
> +#define ENABLE		0x1
> +#define DISABLE		0x0

Defining such common macros names for such incredibly simple boolean values
is asking for trouble, in particular it can possibly collide with other
defines in the global namespace.

Use "true", "false", and the "bool" type, because that is exactly how you
are using these values.

Thanks.
