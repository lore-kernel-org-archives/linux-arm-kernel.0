From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 31 Mar 2010 14:43:13 +0800
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100325233248.GM24984@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
Message-ID: <201003311443.13568.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> LMB... logical memory blocks.

Nice, will be good for the DT work too.

> @@ -483,6 +484,13 @@ static void __init build_mem_type_table(void)
> 
>  #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
> 
> +static void __init *early_alloc(unsigned long sz)
> +{
> +      void *ptr = __va(lmb_alloc(sz, sz));
> +      memset(ptr, 0, PAGE_SIZE);

memset(ptr, 0, sz) ?

Cheers,


Jeremy
