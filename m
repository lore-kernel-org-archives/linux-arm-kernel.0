From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 27 Aug 2018 23:02:43 +0200
Subject: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
In-Reply-To: <20180823185140.GA29028@embeddedor.com>
References: <20180823185140.GA29028@embeddedor.com>
Message-ID: <20180827210243.GG24549@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/2018 13:51:40-0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo { 
> 	int stuff;
>         void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
