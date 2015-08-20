From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 20 Aug 2015 11:08:56 +0100
Subject: [Xen-devel] [PATCH v3 19/20] xen/privcmd: Add support for Linux
 64KB page granularity
In-Reply-To: <1438966019-19322-20-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-20-git-send-email-julien.grall@citrix.com>
Message-ID: <55D5A738.9020403@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 17:46, Julien Grall wrote:
> The hypercall interface (as well as the toolstack) is always using 4KB
> page granularity. When the toolstack is asking for mapping a series of
> guest PFN in a batch, it expects to have the page map contiguously in
> its virtual memory.
> 
> When Linux is using 64KB page granularity, the privcmd driver will have
> to map multiple Xen PFN in a single Linux page.
> 
> Note that this solution works on page granularity which is a multiple of
> 4KB.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
