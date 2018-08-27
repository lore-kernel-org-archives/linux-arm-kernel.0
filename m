From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 27 Aug 2018 09:39:35 +0200
Subject: [PATCH] mtd: rawnand: atmel: use struct_size() in devm_kzalloc()
In-Reply-To: <20180824010938.GA25581@embeddedor.com>
References: <20180824010938.GA25581@embeddedor.com>
Message-ID: <20180827093935.0234da6e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

On Thu, 23 Aug 2018 20:09:38 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
> 	int stuff;
>         void *entry[];
> };
> 
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Can we have all NAND controller drivers patched in a single patch
instead of having one patch per-driver?

Thanks,

Boris
