From: william.kucharski@oracle.com (William Kucharski)
Date: Thu, 1 Nov 2018 18:41:33 -0600
Subject: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
In-Reply-To: <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
 <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
Message-ID: <FD1082D9-916E-47A4-95D3-59F308AD6D55@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Nov 1, 2018, at 3:47 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> -	count = count > PAGE_SIZE ? PAGE_SIZE : count;
> +	count = min_t(size_t, count, PAGE_SIZE);
> 	kbuf = kmalloc(count, GFP_KERNEL);
> 	if (!kbuf)
> 		return -ENOMEM;

Is the use of min_t vs. the C conditional mostly to be more self-documenting?

The compiler-generated assembly between the two versions seems mostly a wash.

    William Kucharski
