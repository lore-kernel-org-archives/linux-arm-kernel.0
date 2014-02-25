From: msalter@redhat.com (Mark Salter)
Date: Tue, 25 Feb 2014 09:10:04 -0500
Subject: [PATCH v4 0/6] generic early_ioremap support
In-Reply-To: <1392238575-10000-1-git-send-email-msalter@redhat.com>
References: <1392238575-10000-1-git-send-email-msalter@redhat.com>
Message-ID: <1393337404.7307.51.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-12 at 15:56 -0500, Mark Salter wrote:
> This patch series takes the common bits from the x86 early ioremap
> implementation and creates a generic implementation which may be used
> by other architectures. The early ioremap interfaces are intended for
> situations where boot code needs to make temporary virtual mappings
> before the normal ioremap interfaces are available. Typically, this
> means before paging_init() has run.
> 
> These patches are layered on top of generic fixmap patches which
> were pulled into 3.14-rc with the exception of the arm patch:
> 
>   https://lkml.org/lkml/2013/11/25/477
> 
> The arm fixmap patch is currently in the akpm tree and has been
> part of linux-next for a while.
> 
> This is version 4 of the patch series. These patches (and underlying
> fixmap patches) may be found at:
> 
>   git://github.com/mosalter/linux.git (early-ioremap-v4 branch)

There have been no comments on this patch series over the past
two weeks. I'd like to get it into linux-next for some wider
testing and eventually into 3.15. Is there something I can do
to help it along?
