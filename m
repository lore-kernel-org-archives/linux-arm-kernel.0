From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 4 Jan 2016 14:41:28 +0100
Subject: [PATCH v2 20/32] metag: define __smp_xxx
In-Reply-To: <1451572003-2440-21-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
Message-ID: <20160104134128.GZ6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 09:08:22PM +0200, Michael S. Tsirkin wrote:
> +#ifdef CONFIG_SMP
> +#define fence() metag_fence()
> +#else
> +#define fence()		do { } while (0)
>  #endif

James, it strikes me as odd that fence() is a no-op instead of a
barrier() for UP, can you verify/explain?
