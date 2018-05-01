From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 19:32:22 +0530
Subject: [PATCH v9 03/27] clk: davinci: psc: allow for dev == NULL
In-Reply-To: <20180427001745.4116-4-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-4-david@lechnology.com>
Message-ID: <8940259b-5811-ce9f-8262-17d39ca0a46f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> +static inline void *_devm_kzalloc(struct device *dev, size_t size, gfp_t flags)
> +{
> +	if (dev)
> +		return devm_kzalloc(dev, size, flags);
> +
> +	return kzalloc(size, flags);
> +}

I have the same question on the utility of this. A memory allocation
error so early on is not going to result in a bootable system anyway.
So, I wonder if its better to just BUG() in such cases. That will
actually help faster debug than returning an error back. I know the push
back on using BUG(), but clock drivers are special, and I think thats
why its seems to be used quite a bit already.

Thanks,
Sekhar
