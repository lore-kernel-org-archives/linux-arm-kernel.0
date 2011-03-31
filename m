From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 31 Mar 2011 09:02:41 -0700
Subject: [PATCH 05/12] mm: alloc_contig_range() added
In-Reply-To: <1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1301587361.31087.1040.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> +       ret = 0;
> +       while (!PageBuddy(pfn_to_page(start & (~0UL << ret))))
> +               if (WARN_ON(++ret >= MAX_ORDER))
> +                       return -EINVAL; 

Holy cow, that's dense.  Is there really no more straightforward way to
do that?

In any case, please pull the ++ret bit out of the WARN_ON().  Some
people like to do:

#define WARN_ON(...) do{}while(0)

to save space on some systems.  

-- Dave
