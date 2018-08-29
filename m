From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 29 Aug 2018 13:41:50 +0200
Subject: [PATCH] drm/rockchip: Use struct_size() in devm_kzalloc()
In-Reply-To: <20180826184712.GA9330@embeddedor.com>
References: <20180826184712.GA9330@embeddedor.com>
Message-ID: <2639880.ggikvLCEDc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 26. August 2018, 20:47:12 CEST schrieb Gustavo A. R. Silva:
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
> or, like in this particular case:
> 
> size = sizeof(struct foo) + sizeof(void *) * count;
> instance = devm_kzalloc(dev, size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count),
> GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

applied to drm-misc with Kees' Review

Thanks
Heiko
